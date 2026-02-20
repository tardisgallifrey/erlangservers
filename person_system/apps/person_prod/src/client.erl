-module(client).
-export([run/1]).

%% we call client:run(ServerName) to make it work
run(ServerName) ->
    %%  client starts the supervisor and passes server name.
    person_sup:start_person(ServerName),
    %% set name from command line input
    Name = string:trim(io:get_line("Enter name: ")),
    %%  see if we get an ok atom from set_name(tom, Name)
    ok = person_server:set_name(ServerName, Name),
    %% run person_server:getname(tom) and print it out.
    io:format("Stored messages: ~p~n", [person_server:get_name(ServerName)]),
    %% return the ok atom, I think.
    ok.

