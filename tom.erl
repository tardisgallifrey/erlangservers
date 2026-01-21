-module(tom).       %% define module, must match filename
-export([start/0, sendharry/0, senddick/0]).    %% Export functions

%% Function to spawn main loop as the server
start() ->
    %% If I'm not wrong, fun() -> is an anonymous function declaration
    Pid = spawn(fun() -> loop(undefined) end),
    %% Register tom as the atom for this Pid
    %% so that other processes can reach by name
    register(tom, Pid),     
    %% This returns the Pid tuple to caller
    %% Essentially, it displays the tuple when started.
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
