# Scott Jodoin - Scimgur - shopify-backend-test

## 📸 **Scimgur** is an image repository web app. [Try it out live! (please wait up to 30 seconds for free dyno)](https://shopify-backend-test.herokuapp.com/)

## 🌐 Upload images:

* You can upload files one at a time, or as a bulk operation.

* Images are processed when they are uploaded to allow for searchability.


## 👥 Users:

* You can upload images anonymously, but you will not be able to delete them after you have uploaded them.

* If you sign up for an account, you will be able to delete or modify information relating to your images.

* Administrators get a special tabular view in the index and can delete / modify and post.

## 🔎 Search

You can perform any combination of the following filters:

* Filter by keyword

* Filter by primary color

* Filter by size - small, medium, or large

You can also **search by image** to see if the image is already in the database. The search algorithm will be able to find images that are of higher or lower resolution, or stretched. It will not be able to find rotated, edited, or similar images.

## Get up and running

* Clone the repository and enter the directory with
```
git clone https://github.com/scottjodoin/shopify-backend-test.git
cd shopify-backend-test
```

* Ensure that your ruby on rails is at least version: 6.0.4.1.

* Developed on: Windows Subsystem for Linux (Ubuntu 18.04 LTS)

* System dependencies: ```sudo apt-get install libmagickwand-dev```

* Then create the database with  ```rails db:create```

* And migrate/seed it with ```rake db:migrate```

* To run the test suite, use ```rails test```

* To start the server, use ```rails server``` and visit ```localhost:3000/```

## Creating the first administrator user

Once you have a server up and running, visit localhost:3000 and sign up for an account. The email can be fake. Then, run the following to make the first user and administrator.

```
bin/rails console
user = User.first
user.admin = true
user.save
```

The user you just created should have administrator priviledges! Happy moderating.

* If you need some sample images, you can find some in the ```/example_images``` directory.

## 🌱 Issues and next steps

* The search by image is stored as a post and needs to be deleted after its first request.

* More robust restrictions on the size of the images could be implemented.

* Searching by user could be added, or perhaps a profile page.

* Setting images to private could be as simple as adding a private:boolean field to the Post database

* Adding images with a multi-select proved difficult due to browser privacy restrictions. With more time I would investigate ActiveStorage further.

* Deleting images in bulk is another task that could be added, probably through a JSON object.

* Adding information and links to the images themselves.