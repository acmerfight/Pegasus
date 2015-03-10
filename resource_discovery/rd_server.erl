-module(rd_server).

-behaviour(gen_server).

-export([
    start_link/0,
    add_tartget_resource_type/1,
    add_local_resource/2,
    fetch_resources/1,
    trade/resources/0
    ]).

-export([init/1, handle_call/3, handle_cast/3, handle_info/2,
        terminate/2, code_change/3]).

-define(SERVER, ?MODULE).

-record(state, {target_resource_types,
               local_resources_tuples,
               found_resources_tuples}).
