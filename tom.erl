-module(tom).       %% define module, must match filename
-export([start/0, send/1]).    %% Export functions

%% Function to spawn main loop as the server
start() ->
    Pid = spawn(fun() -> loop(undefined) end),
    register(tom, Pid),     
    Pid.

%%  Here is where the magic server action takes place
loop(State) ->

    %%  The receive/end block defines a server.
    %%  loop() is just a function containing receive/end
    %%  But, to be a server, it must also loop.
    receive

        {From, get} ->
            From ! {reply, State},
            loop(State);

        %% This is the one doing real work
        {say, Text} ->
            io:format("Tom received: ~p~n", [Text]),
            loop(State);

        %% If we send tom:stop(), we end the server.
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
