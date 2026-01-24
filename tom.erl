-module(tom).       %% define module, must match filename
-export([start/0, send/1, send_dick/0]).    %% Export functions

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

%%  One way to check for valid Pid from server "dick"
%%  Will not be carried forward.  Here for reference.
send_dick() ->
    case whereis(dick) of
        undefined ->
            io:format("Server Dick is not running~n"),
            {error, not_running};

        Pid when is_pid(Pid) ->
            Msg = setMessage(),
            Pid ! {say, Msg},
            ok
    end.

%% more generic send with checks
%% checks that harry is an atom before sending forward
send(harry) when is_atom(harry) ->
    %% dave def: convert to send(whereis()) and send forward 
    send(whereis(harry));

send(dick) when is_atom(dick) ->
    send(whereis(dick));

%% for a server that returns undefined from whereis()
send(undefined) ->
    io:format("Target is not running~n"),
    {error, not_running};

%% If whereis() returns a valid Pid, send a message
send(Pid) when is_pid(Pid) ->
    Msg = setMessage(),
    Pid ! {say, Msg},
    ok.

setMessage() ->
    Text = io:get_line("Enter text to send: "),
    string:trim(Text).
