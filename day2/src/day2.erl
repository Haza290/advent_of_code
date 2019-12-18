%%%-------------------------------------------------------------------
%% @doc day2 public API
%% @end
%%%-------------------------------------------------------------------

-module(day2).

-behaviour(application).

-export([start/2, stop/1, intcode/1, replace_elms/3]).

start(_StartType, _StartArgs) ->
    intcode(replace_elms(readfile(input), 12, 2)).

stop(_State) ->
    ok.

readfile(FileName) ->
  {ok, Binary} = file:read_file(FileName),
  lists:map(fun(I) -> list_to_integer(I) end, string:tokens(erlang:binary_to_list(Binary), ",")).

replace_elms([H|T], Second, Third) ->
    [H] ++ [Second] ++ [Third] ++ lists:nthtail(2, T).

intcode(List) ->
    intcode(List, 1).
intcode(List, Pointer) ->
    Opcode = lists:nth(Pointer, List),
    if 
        Opcode == 99 ->
            lists:nth(1, List);
        true ->
            Input1 = lists:nth(lists:nth(Pointer + 1, List) + 1, List),
            Input2 = lists:nth(lists:nth(Pointer + 2, List) + 1, List),
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
