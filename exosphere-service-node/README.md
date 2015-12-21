# Exosphere Service Framework for Node.js

This NPM module provides a simple and opinionated way to create Exosphere back-end microservices in Node.js.


* put your command handlers as individual files into `app/commands/`

    ```livescript
    # in app/commands/create.ls
    # this is the handler for the "users.create" command
    module.exports = (request_data, response, environment_data) ->
      # request_data contains the data payload of the command sent to you
      # call response with the response data when done
      # environment_data is data that your setup routine prepared,
      # like your database handle
      result = environment.db.create request_data
      response result
    ```

* set up your server like this:

  ```livescript
  require! '../exosphere-service-node'

  exosphere-service-node.listen port: 3000, setup: (done) ->
    # do setup work for your server here, like connecting to your database
    db = ...

    # provide any environment data like your database handle to the async return callback.
    done null, {db}
  ```

