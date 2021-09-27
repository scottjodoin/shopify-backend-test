# Scott Jodoin - shopify-backend-test

📸 **Scimgur** is an image repository web app. It

# 🌐 Upload images:

* You can upload files one at a time, or as a bulk operation.

* Images are processed when they are uploaded to allow for searchability.


# 👥 Users:

* You can upload images anonymously, but you will not be able to delete them after you have uploaded them.

* If you sign up for an account, you will be able to delete or modify information relating to your images.

* Administrators get a special tabular view in the index and can delete / modify and post.

# 🔎 Search

You can perform any combination of the following filters:

* Filter by keyword

* Filter by primary color

* Filter by size - small, medium, or large


# Get up and running

* Clone the repository and enter the directory with
```
git clone https://github.com/scottjodoin/shopify-backend-test.git
cd shopify-backend-test
```

* Ensure that your ruby on rails is at least version: 6.0.4.1.

* Developed on: Windows Subsystem for Linux (Ubuntu 18.04 LTS)

* System dependencies: ```sudo apt-get install libmagickwand-dev```

* Then create the database with  ```rails db:create```

* And migrate/seed it with ```rails db:migrate && db:seed```

* To run the test suite, use ```rails test```

* To start the server, use ```rails server``` and visit ```localhost:3000/```

* If you need some sample images, you can find some in the ```/example_images``` directory.

