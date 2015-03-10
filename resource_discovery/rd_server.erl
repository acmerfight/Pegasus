-module(rd_server).

-behaviour(gen_server).

-export([
    start_link/0,
    add_target_resource_type/1,
    add_local_resource/2,
    fetch_resources/1,
    trade_resources/0
    ]).

-export([init/1, handle_call/3, handle_cast/3, handle_info/2,
        terminate/2, code_change/3]).

-define(SERVER, ?MODULE).

-record(state, {target_resource_types,
               local_resource_tuples,
               found_resource_tuples}).

start_link() ->
    gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

add_target_resource_type(Type) ->
    gen_server:cast(?SERVER, {add_target_resource_type, Type}).

add_local_resource(Type, Resource) ->
    gen_server:cast(?SERVER, {add_local_resource, {Type, Resource}}).

fetch_resources(Type) ->
    gen_server:call(?SERVER, {fetch_resources, Type}).

trade_resources() ->
    gen_server:cast(?SERVER, trade_resources).

init([]) ->
    {ok, #state{target_resource_types = [],
                local_resource_tuples = dict:new(),
                found_resource_tuples = dict:new()}}.

handle_call({fetch_resources, Type}, _From, State) ->
    {reply, dict:find(Type, State#state.found_resource_tuples), State}.

handle_cast({add_target_resource_type, Type}, State) ->
    TargetTypes = State#state.target_resource_types,
    NewTargetTypes = [Type | lists:delete(Type, TargetTypes)],
    {noreply, State#state{target_resource_types = NewTargetTypes}};
handle_cast({add_local_resource, {Type, Resource}}, State) ->
    ResourceTuples = State#state.local_resource_tuples,
    NewResourceTuples = add_resource(Type, Resource, ResourceTuples),
    {noreply, State#state{local_resource_tuples = NewResourceTuples}};
