-module(tom).
-export([start/0, sendharry/0, senddick/0]).

start() ->
    Pid = spawn(fun() -> loop(undefined) end),
    register(tom, Pid),
    Pid.


loop(State) ->
    receive
        {From, get} ->
            From ! {reply, State},
            loop(State);
        {say, Text} ->
            io:format("Tom received: ~p~n", [Text]),
            loop(State);
        stop ->
            ok
    end.

sendharry() ->
    Msg = setMessage(),
    Pid = whereis(harry), 
    Pid ! {say, Msg}.

senddick() ->
    Msg = setMessage(),
    Pid = whereis(dick), 
    Pid ! {say, Msg}.



setMessage() ->
    Text = io:get_line("Enter text to send: "),
    string:trim(Text).
