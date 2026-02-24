
% registry_server.erl
-module(registry_server).
-behaviour(gen_server).

%% API
-export([start_link/0, register/2, lookup/1, unregister/1]).

%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

%% Start the server
start_link() ->
    gen_server:start_link(?MODULE, [], []).

%% Initialize state
init([]) ->
    {ok, #{}}.  % Use a map to hold registered names

%% API to register a name
register(Name, Pid) ->
    gen_server:call(?MODULE, {register, Name, Pid}).

%% API to look up a name
lookup(Name) ->
    gen_server:call(?MODULE, {lookup, Name}).

%% API to unregister a name
unregister(Name) ->
    gen_server:call(?MODULE, {unregister, Name}).

%% Handle calls
handle_call({register, Name, Pid}, _From, State) ->
    NewState = maps:put(Name, Pid, State),
    {reply, ok, NewState};

handle_call({lookup, Name}, _From, State) ->
    case maps:find(Name, State) of
        {ok, Pid} -> {reply, {ok, Pid}, State};
        error -> {reply, not_found, State}
    end;

handle_call({unregister, Name}, _From, State) ->
    NewState = maps:remove(Name, State),
    {reply, ok, NewState}.

%% Handle casts (not used in this example)
handle_cast(_Msg, State) ->
    {noreply, State}.

%% Handle info messages (not used in this example)
handle_info(_Info, State) ->
    {noreply, State}.

%% Cleanup on terminate
terminate(_Reason, _State) ->
    ok.

%% Code change for hot code swapping
code_change(_OldVsn, State, _Extra) ->
    {ok, State}.
