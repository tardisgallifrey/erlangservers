# Learning Erlang Servers

I am learning Erlang Server programming.  As such, I have three servers called, Tom, Dick, and Harry.  These allow sending messages back and forth.  This first version is pretty pathetic, but I will build on it in future branches.

1. main branch is the first one I wrote that functions.
2. v2 is a branch with tom.erl heavily commented.
3. v3 is a branch with checks to see if server is running.
4. v4 is a branch that has a generic `send/1` with server checks.
5. v5 is a basic OTP gen_server that only talks to itself.
6. v6 is OTP gen_server with non-OTP client
7. v7 is OTP gen_server with non-OTP client and DETS (message saving).

### This branch:

We are adding to tom.erl the necessary wiring so that messages are saved using OTP's DETS, a disk backed message logging or saving service.

Because chatGPT missed that I was moving servers forward, his original idea for this revolution was a new server.  I preferred to keep the original.  He added the changes needed so that I could keep going with the original idea.  Server `dick` and `clientd` are that revolution.



