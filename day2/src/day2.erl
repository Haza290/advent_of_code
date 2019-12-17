%%%-------------------------------------------------------------------
%% @doc day2 public API
%% @end
%%%-------------------------------------------------------------------

-module(day2).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    intcode(readfile(input)).

stop(_State) ->
    ok.

readfile(FileName) ->
  {ok, Binary} = file:read_file(FileName),
  lists:map(fun(I) -> list_to_integer(I) end, string:tokens(erlang:binary_to_list(Binary), ",")).


intcode(List) ->
    intcode(List, []).
intcode([99|_], List) ->
    lists:last(List).
intcode([Opcode|[Input1|[Input2|[Output|T]]]], List) ->
    intcode()

%% internal functions
