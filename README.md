# SpaceTweet Example Application

SpaceTweet is a medium-sized example Exosphere application.
It is a Twitter clone that allows to
* log in as a user
* tweet things
* comment on tweets

It uses the following micro-services:
* users service: stores user details (name)
* sessions service: stores user session details
* tweets service: stores tweets
* comments service: stores comments for tweets


## Architecture

This app consists of the following services:

* [web server](web_server): serves the web UI to the outside world
* [api server](api_server): serves the GraphQL data API to the outside world
* [messaging](messaging): provides messaging between services
* [users service](): stores user information (name, email, ...)
* [sessions service](sessions_service): stores who is logged in
* [tweets service](tweets_service): stores tweet data (content)
* [comments service](comments_service): stores comments for tweets
* [photos service](photos_service): stores and serves photos for objects

![architecture diagram](documentation/architecture.png)
