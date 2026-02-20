# Basic OTP application structure 

### This version builds a basic OTP application structure run manually.

After working through the individual build up from a supervisor of a server, we now start to build OTP applications.  This is the first basic step.  It is compiled and run manually in the Erlang REPL (VM).

To build an app requires two additional files and a folder structure.

The minimal folder structure should look like this:
```
application_folder
    |
    |___ ebin (for compiled BEAM files)
    |
    |______src (for source *.erl files)
```
We add `person_server.erl` and `person_sup.erl` to the `src` folder.  We also need an `person.app.src` file and a `person_app.erl` in `src`.

`person.app.src` is a file similar to JSON that describes our application to Erlang's VM.  The `person_app.erl` file is the application file.  Look at these two for examples of how to write them.

However, we have to manually compile each file and move the BEAM product into the `ebin` folder, and start the application just as we did in the previous iteration.

