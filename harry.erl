-module(harry).
-export([start/0, senddick/0, sendtom/0]).

start() ->
    Pid = spawn(fun() -> loop(undefined) end),
    register(harry, Pid),
    Pid.


loop(State) ->
    receive
        {From, get} ->
            From ! {reply, State},
            loop(State);
        {say, Text} ->
            io:format("Harry received: ~p~n", [Text]),
            loop(State);
        stop ->
            ok
    end.

sendtom() ->
    Msg = setMessage(),
    Pid = whereis(tom), 
    Pid ! {say, Msg}.

senddick() ->
    Msg = setMessage(),
    Pid = whereis(dick), 
    Pid ! {say, Msg}.



setMessage() ->
    Text = io:get_line("Enter text to send: "),
    string:trim(Text).
