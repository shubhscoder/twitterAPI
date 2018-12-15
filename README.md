# Twitter Demo API
A REST API created using the Rails framework with the Ruby programming language for a Twitter like application.

# Features offered by API

## Basic Features
* User registration with unique username and email
* User login
* Sessionless user authentication for endpoints using JSON Web Tokens (JWT)
* User logout

## Core Features
* Follow/unfollow a user
* Create a tweet
* Read tweets from all users that have been followed (called Home timeline in Twitter)
* Read tweets of a particular user
* Delete a tweet
* Tests have been performed for all models.

## Additional Features
* Like/unlike a tweet
* Re-tweeting

# Getting Started

## Installing Dependencies
* Ruby - Version 2.4.1</b><br>
    Install the Ruby programming language.<br>It is recommended to do so by installing rbenv or rvm and then installing Ruby using either one of those version managers.<br><b>Rbenv</b> and <b>rvm</b> installation guides for popular operating systems are available on the internet and it is recommended to follow those guides.<br>If your operating system is Ubuntu 16.04, instructions to install Ruby using rbenv or rvm [can be found here](https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-with-rbenv-on-ubuntu-16-04).

* <b>Bundler - Version 1.17.2</b><br>
    Install the Bundler gem.<br>
    This gem allows us to bundle all the dependencies in our Rails application and install it conveniently on remote computers. We will be using this gem to install required dependencies including Rails for our API.
    ```bash
    gem install bundler
    ```
    <b>In case Ruby was installed using rbenv, the following command should be executed after the gem has been installed.</b>
    ```
    rbenv rehash
    ```

## Installing the app
1. Download the project folder and place it at a desired location on the system. On Linux systems, it is preferable to place it in the Home folder of the system.<br>

2. Open the terminal/command prompt on the system and navigate to the project folder.<br>
In Linux systems, it can be done as follows:
    ```bash
    cd <path_to_project_directory>
    ```

3. <b>It is very important to ensure that the master.key file is present in the config folder of the application. This file is not present in the repository. If you do not have it already, please contact the owner of the repository to get the file. The REST API will not work as expected without this file.</b><br>

4. Install all required dependencies as follows:
    ```bash
    bundle install
    ```

5. Perform all database migrations as follows:
    ```bash
    rake db:migrate
    ```

## Running the Server

1. Running the tests:<br>
    The following command can be used to run all the tests:
    ```bash
    rake test
    ```
    If any of these tests fail, certain parts of the application may not work as expected. Please contact the collaborators to fix any issue seen during the use of the application.

2. Starting the server:<br>
    The following command can be used to start the server:
    ```bash
    rails s
    ```
    Output:
    ```bash
    => Booting Puma
    => Rails 5.2.2 application starting in development
    => Run `rails server -h` for more startup options
    Puma starting in single mode...
    * Version 3.12.0 (ruby 2.4.1-p111), codename: Llamas in Pajamas
    * Min threads: 5, max threads: 5
    * Environment: development
    * Listening on tcp://0.0.0.0:3000
    Use Ctrl-C to stop
    ```
    In case the output does not match, there has been some mistake in the installation of the dependencies or the app.<br>
    By default, the server can be accessed using one of the 2 following URLs on a web browser:
    1. http://localhost:3000
    2. http://<machine_ip_address>:3000

# API Endpoint Descriptions:
<b>NOTE: All requests except for registration and login need to be sent alongwith an Authorization header containing a JWT token. Without this token, an unauthorized 401 status message will be received.</b>

## User Registration:
### <b>POST: http://localhost:3000/register</b>
Request body:
```bash
{
    "username": "john"
    "email": "john.doe@gmail.com"
    "password": "john123"
    "firstname": "John"
    "lastname": "Doe"
    "date_of_birth": "1997-08-06"
}
```
Response body:
```javascript
{
    "status": "Ok",
    "message": "Successfully registered!"
}
```

## User Login:
### <b>POST: http://localhost:3000/login</b>
Request body:
```bash
{
    "email": "john.doe@gmail.com"
    "password": "john123"
}
```

Response body:
```javascript
{
    "status": "Ok",
    "message": "Successfully logged in",
    "auth_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo0LCJleHAiOjE1NDQ5NjI0OTR9.ZFpaqxwSW_M8hKY24gWhFOVJtMGLwyhEMTOs6PT0Ci0"
}
```
The auth_token should be saved and sent as "Authorization" header with all subsequent requests.

## User Logout:
### <b>POST: http://localhost:3000/logout</b>
Header:
```bash
{
    "Authorization": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo0LCJleHAiOjE1NDQ5NjI0OTR9.ZFpaqxwSW_M8hKY24gWhFOVJtMGLwyhEMTOs6PT0Ci0"
}
```
Response body:
```javascript
{
    "status": "Ok",
    "message": "Successfully logged out"
}
```

## Follow a user:
### <b>GET: http://localhost:3000/follow/&lt;:username&gt;</b>

Example Request that has been sent: http://localhost:3000/follow/scube<br><br>
Header:
```bash
{
    "Authorization": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo0LCJleHAiOjE1NDQ5NjI0OTR9.ZFpaqxwSW_M8hKY24gWhFOVJtMGLwyhEMTOs6PT0Ci0"
}
```
Response body:
```javascript
{
    "status": "Ok",
    "message": "Started following scube"
}
```

## Unfollow a user:
### <b>GET: http://localhost:3000/unfollow/&lt;:username&gt;</b>

Example Request that has been sent: http://localhost:3000/unfollow/scube<br><br>
Header:
```bash
{
    "Authorization": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo0LCJleHAiOjE1NDQ5NjI0OTR9.ZFpaqxwSW_M8hKY24gWhFOVJtMGLwyhEMTOs6PT0Ci0"
}
```
Response body:
```javascript
{
    "status": "Ok",
    "message": "Unfollowed scube Successfully"
}
```

## Posting a tweet:
### <b>POST: http://localhost:3000/tweet</b>
Header:
```bash
{
    "Authorization": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo0LCJleHAiOjE1NDQ5NjI0OTR9.ZFpaqxwSW_M8hKY24gWhFOVJtMGLwyhEMTOs6PT0Ci0"
}
```
Request body:
```bash
{
    "tweet_content": "John Doe loves to use Twitter and has posted his first tweet!"
}
```

Response body:
```javascript
{
    "status": "Ok",
    "message": "Tweeted Successfully",
    "tweet_id": 4
}
```

## Read tweets from everyone that the user follows:
### <b>GET: http://localhost:3000/timeline</b>
Header:
```bash
{
    "Authorization": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo0LCJleHAiOjE1NDQ5NjI0OTR9.ZFpaqxwSW_M8hKY24gWhFOVJtMGLwyhEMTOs6PT0Ci0"
}
```
Response body:
```javascript
{
    "status": "Ok",
    "message": [
        {
            "username": "john1",
            "tweet_content": "I love to tweet because John Doe follows me!",
            "created_at": "2018-12-15T12:53:51.141Z",
            "tweet_id": 5,
            "number_of_likes": 0
        },
        {
            "username": "jane",
            "tweet_content": "I would like to congratulate Saina Nehwal on her marriage!",
            "created_at": "2018-12-15T12:55:49.681Z",
            "tweet_id": 6,
            "number_of_likes": 0
        },
        {
            "username": "jane",
            "tweet_content": "Saina Nehwal's groom looks amazing!",
            "created_at": "2018-12-15T12:56:17.886Z",
            "tweet_id": 7,
            "number_of_likes": 0
        }
    ]
}
```

## Read tweets from a particular user:
### <b>GET: http://localhost:3000/usertweets/&lt;:username&gt;</b>
Example Request that has been sent: http://localhost:3000/usertweets/jane<br><br>
Header:
```bash
{
    "Authorization": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo0LCJleHAiOjE1NDQ5NjI0OTR9.ZFpaqxwSW_M8hKY24gWhFOVJtMGLwyhEMTOs6PT0Ci0"
}
```
Response body:
```javascript
{
    "status": "Ok",
    "message": [
        {
            "username": "jane",
            "tweet_content": "I would like to congratulate Saina Nehwal on her marriage!",
            "created_at": "2018-12-15T12:55:49.681Z",
            "tweet_id": 6,
            "number_of_likes": 0
        },
        {
            "username": "jane",
            "tweet_content": "Saina Nehwal's groom looks amazing!",
            "created_at": "2018-12-15T12:56:17.886Z",
            "tweet_id": 7,
            "number_of_likes": 0
        }
    ]
}
```
NOTE: The above endpoint can also be used to fetch the tweets of logged in user by passing his/her username as follows:<br>
Example Request that has been sent: http://localhost:3000/usertweets/john<br><br>
Header:
```bash
{
    "Authorization": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo0LCJleHAiOjE1NDQ5NjI0OTR9.ZFpaqxwSW_M8hKY24gWhFOVJtMGLwyhEMTOs6PT0Ci0"
}
```
Response body:
```javascript
{
    "status": "Ok",
    "message": [
        {
            "username": "john",
            "tweet_content": "John Doe loves to use Twitter and has posted his first tweet!",
            "created_at": "2018-12-15T12:41:26.316Z",
            "tweet_id": 4
            "number_of_likes": 0
        }
    ]
}
```

## Delete a tweet:
### <b>DELETE: http://localhost:3000/remove/&lt;:tweet_id&gt;</b>
Example Request that has been sent: http://localhost:3000/remove/4<br><br>
Header:
```bash
{
    "Authorization": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo0LCJleHAiOjE1NDQ5NjI0OTR9.ZFpaqxwSW_M8hKY24gWhFOVJtMGLwyhEMTOs6PT0Ci0"
}
```
Response body:
```javascript
{
    "status": "Ok",
    "message": "Deleted tweet successfully"
}
```
## Liking a tweet:
### <b>GET: http://localhost:3000/like/&lt;:tweet_id&gt;</b>
Example Request that has been sent: http://localhost:3000/like/6<br><br>
Header:
```bash
{
    "Authorization": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo0LCJleHAiOjE1NDQ5NjI0OTR9.ZFpaqxwSW_M8hKY24gWhFOVJtMGLwyhEMTOs6PT0Ci0"
}
```
Response body:
```javascript
{
    "status": "Ok",
    "message": "Liked tweet successfully"
}
```
Now, let us view the result of fetching all tweets from Jane as tweet ID 6 belonged to the tweet written by Jane.
```javascript
{
    "status": "Ok",
    "message": [
        {
            "username": "jane",
            "tweet_content": "I would like to congratulate Saina Nehwal on her marriage!",
            "created_at": "2018-12-15T12:55:49.681Z",
            "tweet_id": 6,
            "number_of_likes": 1
        },
        {
            "username": "jane",
            "tweet_content": "Saina Nehwal's groom looks amazing!",
            "created_at": "2018-12-15T12:56:17.886Z",
            "tweet_id": 7,
            "number_of_likes": 0
        }
    ]
}
```
It can be observed that the number of likes of the 6th tweet has increased to 1.

## Unliking a tweet:
### <b>GET: http://localhost:3000/unlike/&lt;:tweet_id&gt;</b>
Example Request that has been sent: http://localhost:3000/unlike/6<br><br>
Header:
```bash
{
    "Authorization": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo0LCJleHAiOjE1NDQ5NjI0OTR9.ZFpaqxwSW_M8hKY24gWhFOVJtMGLwyhEMTOs6PT0Ci0"
}
```
Response body:
```javascript
{
    "status": "Ok",
    "message": "Unliked tweet"
}
```
Now, let us view the result of fetching all tweets from Jane as tweet ID 6 belonged to the tweet written by Jane.
```javascript
{
    "status": "Ok",
    "message": [
        {
            "username": "jane",
            "tweet_content": "I would like to congratulate Saina Nehwal on her marriage!",
            "created_at": "2018-12-15T12:55:49.681Z",
            "tweet_id": 6,
            "number_of_likes": 0
        },
        {
            "username": "jane",
            "tweet_content": "Saina Nehwal's groom looks amazing!",
            "created_at": "2018-12-15T12:56:17.886Z",
            "tweet_id": 7,
            "number_of_likes": 0
        }
    ]
}
```
It can be observed that the number of likes of the 6th tweet has decreased to 0.

## Re-tweet an existing tweet:
### <b>GET: http://localhost:3000/retweet/&lt;:tweet_id&gt;</b>
Example Request that has been sent: http://localhost:3000/retweet/6<br><br>
Header:
```bash
{
    "Authorization": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo0LCJleHAiOjE1NDQ5NjI0OTR9.ZFpaqxwSW_M8hKY24gWhFOVJtMGLwyhEMTOs6PT0Ci0"
}
```
Response body:
```javascript
{
    "status": "Ok",
    "message": "Retweeted Successfully",
    "retweet_id": 8
}
```

Since we re-tweeted using John's account, we can check if it is visible by viewing all of John's tweets.

```javascript
{
    "status": "Ok",
    "message": [
        {
            "username": "john",
            "tweet_content": "I would like to congratulate Saina Nehwal on her marriage!",
            "created_at": "2018-12-15T14:06:35.446Z",
            "tweet_id": 8,
            "number_of_likes": 0
        }
    ]
}
```
