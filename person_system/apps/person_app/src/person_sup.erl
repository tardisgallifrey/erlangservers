-module(person_sup).
-behaviour(supervisor).

-export([start_link/0, start_person/1]).
-export([init/1]).

%% API %%
start_person(Name) ->
    ChildSpec = #{
                  id => {person_server, Name},
                  start => {person_server, start, [Name]},
                  restart => permanent,
                  shutdown => 5000,
                  type => worker,
                  modules => [person_server]
                 },
    supervisor:start_child(?MODULE, ChildSpec).


start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init([]) ->
    RestartStrategy = one_for_one,
    MaxRestarts = 5,
    MaxSeconds = 10,

    SupFlags = #{
        strategy => RestartStrategy,
        intensity => MaxRestarts,
        period => MaxSeconds
    },

    {ok, {SupFlags, []}}.
