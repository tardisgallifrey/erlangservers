-module(dick).
-export([start/0, sendtom/0, sendharry/0]).

start() ->
    Pid = spawn(fun() -> loop(undefined) end),
    register(dick, Pid),
    Pid.


loop(State) ->
    receive
        {From, get} ->
            From ! {reply, State},
            loop(State);
        {say, Text} ->
            io:format("Dick received: ~p~n", [Text]),
            loop(State);
        stop ->
            ok
    end.

sendtom() ->
    Msg = setMessage(),
    Pid = whereis(tom), 
    Pid ! {say, Msg}.

sendharry() ->
    Msg = setMessage(),
    Pid = whereis(harry), 
    Pid ! {say, Msg}.



setMessage() ->
    Text = io:get_line("Enter text to send: "),
    string:trim(Text).
