-module(person_sup).
-behaviour(supervisor).

-export([start_link/0]).
-export([init/1]).

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

    PersonChild = #{
        id => dick,
        start => {dick, start, []},
        restart => permanent,
        shutdown => 5000,
        type => worker,
        modules => [dick]
    },

    {ok, {SupFlags, [PersonChild]}}.
