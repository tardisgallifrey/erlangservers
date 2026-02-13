# Learning Erlang Servers

I am learning Erlang Server programming.  As such, I have three servers called, Tom, Dick, and Harry.  These allow sending messages back and forth.  This first version is pretty pathetic, but I will build on it in future branches.

1. main branch is the first one I wrote that functions.
2. v2 is a branch with tom.erl heavily commented.
3. v3 is a branch with checks to see if server is running.
4. v4 is a branch that has a generic `send/1` with server checks.
5. v5 is a basic OTP gen_server that only talks to itself.
6. v6 is OTP gen_server with non-OTP client
7. v7 is OTP gen_server with non-OTP client and DETS (message saving).
8. v8 is OTP gen_server with DETS and supervisor.
9. v9 turns our server generic and allows us to call person_server with a server name.

### This branch:

In this revolution, we convert our server into person_server that will create individually named servers.  These become server instances that can all stand up at one time.  Each is configured with DETS to save its own person name.  The client has also be refactored to run by calling a specific server instance into being for saving and reading a name, with persistence.




