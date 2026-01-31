
-module(tom).
-behaviour(gen_server).

-export([start/0, say/1, stop/0]).
-export([init/1, handle_cast/2, handle_call/3, terminate/2]).

%% This is an intermediate step.  This isn't my code, but chatGPT's
%% It is meant to show the difference between older Erlang server code
%% and OTP gen_server code

%%% ===== Public API =====
%%% These are the functions we can use

start() ->
    gen_server:start_link({local, tom}, ?MODULE, undefined, []).

%% Yes, this server only talks to itself.
say(Text) ->
    gen_server:cast(tom, {say, Text}).

stop() ->
    gen_server:call(tom, stop).

%%% ===== gen_server callbacks =====
%%% These are the OTP gen_server functions we tie our API to

init(State) ->
    {ok, State}.

handle_cast({say, Text}, State) ->
    io:format("Tom received: ~p~n", [Text]),
    {noreply, State}.

handle_call(stop, _From, State) ->
    {stop, normal, ok, State}.

terminate(_Reason, _State) ->
    ok.
