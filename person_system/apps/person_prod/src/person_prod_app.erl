%%%-------------------------------------------------------------------
%% @doc person_prod public API
%% @end
%%%-------------------------------------------------------------------

-module(person_prod_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    person_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
