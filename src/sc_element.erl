-module(sc_element).

-behaviour(gen_server).

-export([
    start_link/2,
    create/2,
    create/1,
    fetch/1,
    replace/2,
    delete/1]).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-define(SERVER, ?MODULE).

-define(DEFAULT_LEASE_TIME, (60 * 60 * 24)).

-record(state, {value, lease_time, start_time}).
