-module(harry).
-export([start/0, send/1]).

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

send(tom) when is_atom(tom) ->
    send(whereis(tom));

send(dick) when is_atom(dick) ->
    send(whereis(dick));

send(undefined) ->
    io:format("Target is not running."),
    {error, not_running};

send(Pid) when is_pid(Pid) ->
    Msg = setMessage(),
    Pid ! {say, Msg},
    ok.

setMessage() ->
    Text = io:get_line("Enter text to send: "),
    string:trim(Text).
