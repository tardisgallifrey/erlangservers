
-module(client).
-export([run/0]).

run() ->
    tom:start(),
    Name = string:trim(io:get_line("Enter name: ")),
    ok = tom:set_name(Name),
    io:format("Stored name: ~p~n", [tom:get_name()]),
    ok.
