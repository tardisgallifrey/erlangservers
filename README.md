# Learning Erlang Servers

I am learning Erlang Server programming.  As such, I have three servers called, Tom, Dick, and Harry.  These allow sending messages back and forth.  This first version is pretty pathetic, but I will build on it in future branches.

1. main branch is the first one I wrote that functions.
2. v2 is a branch with tom.erl heavily commented.
3. v3 is a branch with checks to see if server is running.
4. v4 is a branch that has a generic `send/1` with server checks.
5. v5 is a basic OTP gen_server that only talks to itself.

### This branch:

Here, we have a single OTP gen_server example.  It has three public functions; start, stop, and say.  It only talks to itself.


