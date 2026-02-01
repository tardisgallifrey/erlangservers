
-module(client).
-export([run/0]).

%% we call client:run() to make it work
run() ->
    %%  start tom if not already started 
    %%  don't worry, you can't mess this up
    tom:start(),
    %% set name from command line input
    Name = string:trim(io:get_line("Enter name: ")),
    %%  see if we get an ok atom from set_name(Name)
    ok = tom:set_name(Name),
    %% run tom:getname() and print it out.
    io:format("Stored name: ~p~n", [tom:get_name()]),
    %% return the ok atom, I think.
    ok.
