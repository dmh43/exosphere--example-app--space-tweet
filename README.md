# Exosphere Developer SDK POC

This is a proof of concept of the Exosphere developer SDK.
It implements a simple Twitter clone (SpaceTweet) as a practical example.


## Installation

```
./install
```


## Run

```
./start
```


## Architecture

This app consists of the following services:

* [web server](web_server): serves the web UI to the outside world
* [api server](api_server): serves the GraphQL data API to the outside world
* [people service](people_service): stores user information (name, email, ...)
* [sessions service](sessions_service): stores who is logged in
* [tweets service](tweets_service): stores tweet data (content)
* [comments service](comments_service): stores comments for tweets
* [photos service](photos_service): stores and serves photos for objects
