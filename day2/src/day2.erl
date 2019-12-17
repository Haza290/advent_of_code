%%%-------------------------------------------------------------------
%% @doc day2 public API
%% @end
%%%-------------------------------------------------------------------

-module(day2).

-behaviour(application).

-export([start/2, stop/1, intcode/1]).

start(_StartType, _StartArgs) ->
    intcode(readfile(input)).

stop(_State) ->
    ok.

readfile(FileName) ->
  {ok, Binary} = file:read_file(FileName),
  lists:map(fun(I) -> list_to_integer(I) end, string:tokens(erlang:binary_to_list(Binary), ",")).


intcode(List) ->
    intcode(List, 0).
intcode(List, Pointer) ->
    Opcode = lists:nth(Pointer, List),
    if 
        Opcode == 99 ->
            lists:nth(0, List);
        true ->
            Input1 = lists:nth(Pointer + 1, List),
            Input2 = lists:nth(Pointer + 2, List),
            OuputElm = lists:nth(Pointer + 3, List),
            if
                Opcode == 1 ->
                    Output = Input1 + Input2;
                true ->
                    Output = Input1 * Input2
            end,
            intcode(lists:sublist(List, OuputElm) ++ [Output] ++ lists:nthtail(OuputElm + 1, List), Pointer + 4)
    end.

%% internal functions
