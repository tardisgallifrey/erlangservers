-module(clientd).
-export([run/0]).

%% The only change is to call server dick instead of tom.
run() ->
    dick:start(),
    Name = string:trim(io:get_line("Enter name: ")),
    ok = dick:set_name(Name),
    io:format("Stored name: ~p~n", [dick:get_name()]),
    ok.
