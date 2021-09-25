class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
  def index
    params.permit(:normal)
    @posts = Post.all
      .includes(:primary_color,:secondary_color,:user)
  end

  def image_search
    params.permit(:image)
    
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    
    @post.user = current_user if user_signed_in?
    


    respond_to do |format|
      if @post.save

        # calculate the fingerprint of the image
        require 'rubygems'
        require 'RMagick'
        require "open-uri"
        my64 = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789+-'
        kernel_string = ""

        image_blob = @post.image.blob.download

        pixels = Magick::Image.from_blob(image_blob)
          .first
          .resize(3, 3)
          .get_pixels(0,0,3,3)

        for pixel in pixels
          # https://stackoverflow.com/questions/12651632/rmagick-pixel-color-value
          kernel_string += my64[pixel.red   / 256 / 4] # imagemagick (and thereby rmagick) uses large numbers
          kernel_string += my64[pixel.green / 256 / 4]
          kernel_string += my64[pixel.blue  / 256 / 4]
        end

        @post.fingerprint = kernel_string
        @post.save

        # TODO: calculate the most common colours based on a smaller version of the image
        resolution = 20
        
        filters_by_id = FilterColor.all.map { |filter| [filter.id, filter] }.to_h

        histogram = Hash.new(0)

        pixels = Magick::Image.from_blob(image_blob)
          .first
          .resize(resolution, resolution)
          .get_pixels(0,0,resolution,resolution)
        
        for pixel in pixels
          pixel_dists = {}

          filters_by_id.each do |filter_id, filter| 
            rgb = hex_color_to_rgb(filter.color)
            pixel_dists[filter_id] = Math.sqrt(
              ((pixel.red / 256) - rgb[:red]) ** 2 +
              ((pixel.green / 256) - rgb[:green]) ** 2 +
              ((pixel.blue / 256) - rgb[:blue]) ** 2
            )
          end

          shortest_dist_id = smallest_hash_key(pixel_dists)
          histogram[shortest_dist_id] += 1.0
        end

        primary_id = largest_hash_key(histogram)
        histogram.delete(primary_id)
        secondary_id = largest_hash_key(histogram)
        
        @post.primary_color = filters_by_id[primary_id]
        @post.secondary_color = filters_by_id[secondary_id]
        @post.save
        
        # output
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
      
    end
  end

  def hex_color_to_rgb(hex)
    rgb = hex.match(/^(..)(..)(..)$/).captures.map(&:hex)
    return {red: rgb[0], green: rgb[1], blue: rgb[2]}
  end

  def largest_hash_key(hash)
    # https://stackoverflow.com/a/6040733/13289307
    hash.max_by{|k,v| v}[0]
  end

  def smallest_hash_key(hash)
    hash.min_by{|k,v| v}[0]
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    if not current_user.admin and not current_user == @post.user
      format.html { render :edit, status: :forbidden, notice: "You do not have permission to delete this post." }
      format.json { render json: "No permission", status: :unprocessable_entity }
      return
    end

    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :description, :image)
    end
end
