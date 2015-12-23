# HTTP Listener

This NPM module provides a class that records incoming HTTP calls.
This is useful for black-box testing of network services.


## Usage

In your test suite, set up a listener:

```livescript
listener = new HttpListener().listen 7777, <callback>
```

Now this instance records all calls made to port 7777.
Access the recorded calls through:

```livescript
listener.calls
```

A more detailed example is given [here](features/record.feature).


Finally, close your instance through

```livescript
listener.close()
```

More details [here](features/close.feature).
