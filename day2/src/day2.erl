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
    intcode(List, 0).
intcode([99|T], List) ->
    lists:last(List).
intcode(List, Pointer) ->
    Input1 = lists:nth(Pointer + 1),
    Input2 = lists:nth(Pointer + 2),

    if 
        lists:nth(Pointer) == 1 ->
            Output = Input1 + Input2;
        true ->
            Output = Input1 * Input2
    end;
    intcode(lists:, Pointer + 4)


getInput
%% internal functions
