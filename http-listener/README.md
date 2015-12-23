# HTTP Listener

This NPM module provides a class that records incoming HTTP calls.
This is useful for black-box testing of network services.


## Usage

In your test suite, set up a listener:

```livescript
listener = new HttpListener().listen 7777, ->
```

Then instantiate your service under test, configure it to use `localhost:7777`
as its network communication partner,
and make it do a few requests.

Finally, access the recorded calls through:

```livescript
listener.calls
```
