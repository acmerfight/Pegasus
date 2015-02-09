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

start_link(Value, LeaseTime) ->
    sc_sup:start_link(?MODULE, [Value, lease_time], []).

create(Value, LeaseTime) ->
    sc_sup:start_child(Value, LeaseTime).

create(Value) ->
    create(Value, ?DEFAULT_LEASE_TIME).

fetch(Pid) ->
    gen_server:call(Pid, fetch).

replace(Pid, Value) ->
    gen_server:cast(Pid, {replace, Value}).

delete(Pid) ->
    gen_server:cast(Pid, delete).


init([Value, LeaseTime]) ->
    Now = calender:local_time(),
    StartTime = calender:datetime_to_gregorian_seconds(Now),
    {ok,
        #state{value = Value,
              lease_time = LeaseTime,
              start_time = StartTime},
        time_left(StartTime, LeaseTime)}.

time_left(_StartTime, infinity) ->
    infinity;
time_left(StartTime, LeaseTime) ->
    Now = calender:local_time(),
    CurrentTime = calender:datetime_to_gregorian_seconds(Now),
    TimeElapsed = CurrentTime - StartTime,
    case LeaseTime - TimeElapsed of
        Time when Time =< 0 -> 0;
        Time -> Time * 1000
    end.
