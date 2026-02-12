-module(dick).
-behaviour(gen_server).

%% This is the original tom server, but
%% improved to use DETS.  In this version,
%% I kept the original functions, but commented them out
%% In future versions, I'll remove those.
%%
%% To use this server, use clientd:run() instead.

-export([start/0, set_name/1, get_name/0, stop/0]).
-export([init/1, handle_call/3, handle_cast/2, terminate/2]).

%%% ===== API =====

start() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, #{}, []).

set_name(Name) ->
    gen_server:call(?MODULE, {set_name, Name}).

get_name() ->
    gen_server:call(?MODULE, get_name).

stop() ->
    gen_server:call(?MODULE, stop).

%%% ===== Callbacks =====

%% Newer generic init, just an empty map
%%init(#{}) ->
%%    {ok, #{name => undefined}}.

%% init with dets (no table required for this one)
%% it only saves one name at a time.
init(#{}) ->
    {ok, _} = dets:open_file(person_data, [{file, "person_data.dets"}]),

    Name =
        case dets:lookup(person_data, name) of
            [{name, SavedName}] -> SavedName;
            [] -> undefined
        end,

    {ok, #{name => Name}}.

%%handle_call({set_name, Name}, _From, State) ->
%%    NewState = State#{name => Name},
%%    {reply, ok, NewState};

%% set_name uses dets to save the name from the 
%% sender, but only one name.  Still uses 
%% State map to store Name
handle_call({set_name, Name}, _From, State) ->
    ok = dets:insert(person_data, {name, Name}),
    NewState = State#{name => Name},
    {reply, ok, NewState};

%% Because we use State, this function needed no changes
handle_call(get_name, _From, State) ->
    {reply, maps:get(name, State, undefined), State};

handle_call(stop, _From, State) ->
    {stop, normal, ok, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.

%%terminate(_, _) ->
%%    ok.

%% terminate now needs to close dets
terminate(_Reason, _State) ->
    dets:close(person_data),
    ok.
