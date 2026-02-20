# An OTP application using Rebar3 as the build tool

The same application we have been working on, but instead of manually building everything, we can now use Rebar3 as a build tool, just like Gradle.

Using the following commands, we can generate an app, build it, run it and maintain it with less effort.

```
>> rebar3 new app myApp
    (the above will build a folder scaffolding and files for an OTP app)
>> cd myApp
    (editing app)
>> rebar3 compile
    (compiles the app)
>> rebar3 shell
    (if myApp.app.src is configured correctly, the REPL will start and the app will also start)
```

