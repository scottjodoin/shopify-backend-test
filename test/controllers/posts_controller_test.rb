require 'test_helper'
class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  def current_user
    @current_user
  end

  setup do
    @tom_post = posts(:one)
    @bob_post = posts(:two)
    @current_user = nil
  end

  test "should get index" do
    get posts_url
    assert_response :success
  end

  test "should get new" do
    get new_post_url
    assert_response :success
  end

  test "should create post" do
    image = fixture_file_upload('/files/two.jpg','image/jpg')
    assert_difference('Post.count') do
      post posts_url, params: { posts: {"0"=>{image: image, description: "This is the second image", title: "Two"} } }
    end

    assert_redirected_to "/posts/#{Post.last.id}"
  end

  test "should show post" do
    get post_url(@tom_post)
    assert_response :success
  end

  test "anonymous user redirect on edit" do
    get edit_post_url(@tom_post)
    assert_redirected_to post_url(@tom_post)
  end

  test "anonymous user redirect on update" do
    patch post_url(@tom_post), params: { post: {title: @tom_post.title + "2", description: @tom_post.description + "1" } }
    assert_redirected_to post_url(@tom_post)
  end

  test "anonymous user redirect on destroy" do
    delete post_url(@tom_post)
    assert_redirected_to post_url(@tom_post)
  end

  test "user redirect on other update" do
    sign_in users(:tom)
    @current_user = users(:tom)
    patch post_url(@bob_post), params: { post: {title: @tom_post.title + "2", description: @tom_post.description + "1" } }
    assert_redirected_to post_url(@bob_post)
    sign_out :tom
  end

  test "user redirect on other destroy" do
    sign_in users(:tom)
    @current_user = users(:tom)
    delete post_url(@bob_post)
    assert_redirected_to post_url(@bob_post)
    sign_out :tom
  end

  test "user should create post" do
    sign_in users(:tom)
    @current_user = users(:tom)

    image = fixture_file_upload('/files/two.jpg','image/jpg')

    assert_difference('Post.count') do
      post posts_url, params: { posts: {"0"=>{image: image, description: "This is tom's image", title: "Two"} } }
    end

    sign_out :tom
  end

  test "user should edit his own post" do
    sign_in users(:tom)
    @current_user = users(:tom)

    patch post_url(@tom_post), params: { post: {title: "Tom title", description: "Tom description" } }

    updated_post = Post.find(@tom_post.id)

    assert_equal "Tom title", updated_post.title
    assert_equal "Tom description", updated_post.description

    sign_out :tom  
  end

  test "user should delete his own post" do
    sign_in users(:tom)
    @current_user = users(:tom)

    assert_difference('Post.count', -1) do
      delete post_url(@tom_post)
    end

    sign_out :tom  
  end

  test "admin should edit other post" do
    sign_in users(:bob_admin)
    @current_user = users(:bob_admin)

    patch post_url(@tom_post), params: { post: {title: "Bob title", description: "Bob description" } }

    updated_post = Post.find(@tom_post.id)

    assert_equal "Bob title", updated_post.title
    assert_equal "Bob description", updated_post.description

    sign_out :bob_admin  
  end

  test "admin should delete other post" do
    sign_in users(:bob_admin)
    @current_user = users(:bob_admin)

    assert_difference('Post.count', -1) do
      delete post_url(@tom_post)
    end

    sign_out :bob_admin  
  end

end
