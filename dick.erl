-module(dick).
-export([start/0, send/1]).

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

send(harry) when is_atom(harry) ->
    send(whereis(harry));

send(tom) when is_atom(tom) ->
    send(whereis(tom));

send(undefined) ->
    io:format("Target is not running~n"),
    {error, not_running};

send(Pid) when is_pid(Pid) ->
    Msg = setMessage(),
    Pid ! {say, Msg},
    ok.


setMessage() ->
    Text = io:get_line("Enter text to send: "),
    string:trim(Text).
