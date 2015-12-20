# SpaceTweet Web Server

This is the web server component of the SpaceTweet application.

It is a Node.js app written in LiveScript.


## What is where
Generally, the `app` contains all the application-specific logic,
the other directories all the hocus pocus necessary to make this Node app fly.
* `bin`: command-line scripts provided by this service
* `node_modules`: dependencies
* `servers`: all the possible horrible server infrastructure
  that is required by ExpressJS,
  and which would ideally be hidden
  inside a more opinionated and high-level web server framework.


# Installation
* install Node.js (`brew install nodejs`)
* add `./bin` to your path

```
bin/setup
```




## Starting the server

```
bin/start
```


## Running tests

```
bin/spec
```
