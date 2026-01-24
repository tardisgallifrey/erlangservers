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

%%  Here is where the magic server action takes place
loop(State) ->

    %%  The receive/end block defines a server.
    %%  loop() is just a function containing receive/end
    %%  But, to be a server, it must also loop.
    receive

        %% These are actions
        %% They use arrows -> but don't get confused
        %% When a received tuple matches one of these,
        %% The action takes place (much like a case/switch).
        {From, get} ->
            From ! {reply, State},
            %% Actions must call loop and give State as a parameter
            %% Yes, it's recursive.
            loop(State);

        %% This is the one doing real work
        %% When a send() forwards a message to the appropriate
        %% server, it sends a tuple (For reference, look at sendharry())
        {say, Text} ->
            io:format("Tom received: ~p~n", [Text]),
            loop(State);

        %% If we send tom:stop(), we end the server.
        stop ->
            ok
    end.

%% These functions handle sending messages to other servers.
%% The Pid ! {say, Msg) does the work of sending
%% Pid gets its target from the whereis().  
%% Each server registers its name to the Erlang VM,
%% so, these servers only work inside one VM.
sendharry() ->
    Msg = setMessage(),
    Pid = whereis(harry), 
    Pid ! {say, Msg}.

senddick() ->
    Msg = setMessage(),
    Pid = whereis(dick), 
    Pid ! {say, Msg}.


%%  this function gets a line of text from the user
%%  It's set aside to not repeat myself and make things
%%  more readable.
setMessage() ->
    Text = io:get_line("Enter text to send: "),
    %% In Erlang, the last line of a function is the return value.
    string:trim(Text).
