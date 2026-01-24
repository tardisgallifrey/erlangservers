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

%% Generic function instead of one for each server.
%% "undefined" check MUST come first.  Semantic error if not.
send(undefined) ->
    io:format("Target is not running.~n"),
    {error, not_running};

%% if this were first, it would return undefined
%% send(undefined) would pass because is_atom(undefined) is true.
%% process would go into eternal loop
send(Name) when is_atom(Name) ->
    send(whereis(Name));

send(Pid) when is_pid(Pid) ->
    Msg = setMessage(),
    Pid ! {say, Msg},
    ok.

setMessage() ->
    Text = io:get_line("Enter text to send: "),
    string:trim(Text).
