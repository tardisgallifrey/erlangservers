-module(person_server).
-behaviour(gen_server).

%% This is the original tom server, but
%% improved to use DETS.  In this version,
%% I kept the original functions, but commented them out
%% In future versions, I'll remove those.
%%
%% To use this server, use clientd:run() instead.

-export([start/1, set_name/2, get_name/1, stop/0]).
-export([init/1, handle_call/3, handle_cast/2, terminate/2]).

%%% ===== API =====

start(Name) ->
    gen_server:start_link({local, Name}, ?MODULE, Name, []).

set_name(Server, Name) ->
    gen_server:call(Server, {set_name, Name}).

get_name(Server) ->
    gen_server:call(Server, get_name).

stop() ->
    gen_server:call(?MODULE, stop).

%%% ===== Callbacks =====

init(Name) ->
    %% set filename for dets based on Name 
    FileName = atom_to_list(Name) ++ ".dets",
    TableName = Name,

    {ok, _} = dets:open_file(TableName, [{file, FileName}]),

    SavedName =
        case dets:lookup(TableName, name) of
            [{name, N}] -> N;
            [] -> undefined
        end,

    {ok, #{person => Name,
           table => TableName,
           name => SavedName}}.

handle_call({set_name, NewName}, _From, State) ->
    Table = maps:get(table, State),
    ok = dets:insert(Table, {name, NewName}),
    NewState = State#{name => NewName},
    {reply, ok, NewState};

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
