# Learning Erlang Servers

I am learning Erlang Server programming.  As such, I have three servers called, Tom, Dick, and Harry.  These allow sending messages back and forth.  This first version is pretty pathetic, but I will build on it in future branches.

1. main branch is the first one I wrote that functions.
2. v2 is a branch with tom.erl heavily commented.
3. v3 is a branch with checks to see if server is running

### This branch:

Server `tom` contains two methods for checking if a server returns a valid `Pid`.  We won't know the correct `Pid`, but also we want to see if it is valid.  The `send_dick()` function is one way to see it work, but the `send(atom)` is a better way.


