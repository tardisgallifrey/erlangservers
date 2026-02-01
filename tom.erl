-module(tom).
-behaviour(gen_server).

%% Guess: top exports (my api), bottom exports (behaviour api)
-export([start/0, set_name/1, get_name/0, stop/0]).
-export([init/1, handle_call/3, terminate/2, handle_cast/2]).

%% again, this is chatGPT code, not mine

%%% ===== API =====

start() ->
    %% calls init() callback below
    %% start_link(ServerName, Module, Args, Options)
    %% ServerName is a tuple of 2 atoms, scope and name
    %% ?MODULE is the current module, here tom:init().
    %% #{} is an empty map (key=>value) of args
    %% [] is an empty list of options
    gen_server:start_link({local, tom}, ?MODULE, #{}, []).

set_name(Name) ->
    %% Every call() calls a matching hande_call() below
    gen_server:call(tom, {set_name, Name}).

get_name() ->
    gen_server:call(tom, get_name).

stop() ->
    gen_server:call(tom, stop).

%%% ===== Callbacks =====

init(State) ->
    {ok, State}.

%% if the tuple pattern from the call matches here,
%% the action of the function is taken
%% we don't care about From because of the _
%% we do care about State as we will create
%% NewState by mapping name to Name and returning
%% NewState
handle_call({set_name, Name}, _From, State) ->
    NewState = State#{name => Name},
    {reply, ok, NewState};

handle_call(get_name, _From, State) ->
    %% State is a map; maps:get finds value of name in State.
    %% undefined is the default.
    {reply, maps:get(name, State, undefined), State};

handle_call(stop, _From, State) ->
    {stop, normal, ok, State}.

terminate(_, _) ->
    ok.

%% needed only to handle OTP contract
%% and avoid warning error -- it is not used
handle_cast(_Msg, State) ->
    {noreply, State}.


