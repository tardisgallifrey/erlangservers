-module(tom).
-behaviour(gen_server).

%% Public API
-export([start/0, save_message/1, get_all/0]).

%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2, terminate/2, code_change/3]).

-define(TABLE, messages).

%%% =========================
%%% API
%%% =========================

start() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

save_message(Msg) ->
    gen_server:call(?MODULE, {save, Msg}).

get_all() ->
    gen_server:call(?MODULE, get_all).

%%% =========================
%%% gen_server callbacks
%%% =========================

init([]) ->
    %% Open DETS table
    {ok, _} = dets:open_file(?TABLE, [{file, "messages.dets"}]),

    %% Determine next key
    Keys = dets:foldl(fun({K, _V}, Acc) ->
                              max(K, Acc)
                      end, 0, ?TABLE),

    NextId = Keys + 1,

    {ok, #{next_id => NextId}}.

handle_call({save, Msg}, _From, State) ->
    Id = maps:get(next_id, State),

    ok = dets:insert(?TABLE, {Id, Msg}),

    NewState = State#{next_id => Id + 1},

    {reply, ok, NewState};

handle_call(get_all, _From, State) ->
    Messages = dets:foldl(fun({_K, V}, Acc) ->
                                  [V | Acc]
                          end, [], ?TABLE),

    {reply, lists:reverse(Messages), State};

handle_call(_Request, _From, State) ->
    {reply, {error, unknown_request}, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    dets:close(?TABLE),
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.
