# SpaceTweet Web Server

This is the web server component of the SpaceTweet application.

It is an [ExpressJS](http://expressjs.com) app written in LiveScript.


## What is where
The [app](app) folder contains all the application-specific logic.
This is the playground for app developers.
The other directories contain all the hocus pocus necessary
to make this Express app fly.
* `bin`: command-line scripts provided by this service
* `node_modules`: dependencies
* `servers`: all the server infrastructure required by ExpressJS,
  and which would ideally be hidden
  inside a more opinionated and high-level web server framework.


# Installation
* install Node.js (`brew install nodejs`)
* add `./bin` to your path

```
bin/setup
```


## Starting the server
* `bin/start`
* then go to [localhost:3000](http://localhost:3000)


## Development
* the browser hot-reloads assets,
  so simply save in your editor and see the updates in the browser


## Running tests

```
bin/spec
```
