-module(day5).
-export([start/0, intcode/1, decode_opcode/1, replace_elms/3, readfile/1, get_param_value/3]).

start() ->
    intcode(readfile(input)).

intcode(List) ->
    intcode(List, 1).
intcode(List, Pointer) ->
    {Param2Mode,Param1Mode,Op} = decode_opcode(lists:nth(Pointer,List)),
    case Op of
        99 ->
            List;
        1 ->
            Param1 = get_param_value(lists:nth(Pointer + 1, List), Param1Mode, List),
            Param2 = get_param_value(lists:nth(Pointer + 2, List), Param2Mode, List),
            OutputKey = lists:nth(Pointer + 3, List),
            intcode(lists:sublist(List,OutputKey) ++ [Param1 + Param2] ++ lists:nthtail(OutputKey + 1, List), Pointer + 4);
        2 ->
            Param1 = get_param_value(lists:nth(Pointer + 1, List), Param1Mode, List),
            Param2 = get_param_value(lists:nth(Pointer + 2, List), Param2Mode, List),
            OutputKey = lists:nth(Pointer + 3, List),
            intcode(lists:sublist(List,OutputKey) ++ [Param1 * Param2] ++ lists:nthtail(OutputKey + 1, List), Pointer + 4);
        3 ->
            {ok, Input} = io:read("Enter input: "),
            OutputKey = lists:nth(Pointer + 1, List),
            intcode(lists:sublist(List,OutputKey) ++ [Input] ++ lists:nthtail(OutputKey + 1, List), Pointer + 2);
        4 ->
            Param1 = get_param_value(lists:nth(Pointer + 1, List), Param1Mode, List),
            io:format("Output is: ~w~n", [Param1]),
            intcode(List, Pointer + 2);
        5 ->
            Param1 = get_param_value(lists:nth(Pointer + 1, List), Param1Mode, List),
            case Param1 /= 0 of
                true ->
                    intcode(List, get_param_value(lists:nth(Pointer + 2, List), Param2Mode, List) + 1);
                false ->
                    intcode(List, Pointer + 3)
            end;
        6 ->
            Param1 = get_param_value(lists:nth(Pointer + 1, List), Param1Mode, List),
            case Param1 == 0 of
                true ->
                    intcode(List, get_param_value(lists:nth(Pointer + 2, List), Param2Mode, List) + 1);
                false ->
                    intcode(List, Pointer + 3)
            end;
        7 ->
            Param1 = get_param_value(lists:nth(Pointer + 1, List), Param1Mode, List),
            Param2 = get_param_value(lists:nth(Pointer + 2, List), Param2Mode, List),
            OutputKey = lists:nth(Pointer + 3, List),
            case Param1 < Param2 of
                true ->
                    OutputValue = 1;
                false ->
                    OutputValue = 0
            end,
            intcode(lists:sublist(List,OutputKey) ++ [OutputValue] ++ lists:nthtail(OutputKey + 1, List),Pointer + 4);
        8 ->
            Param1 = get_param_value(lists:nth(Pointer + 1, List), Param1Mode, List),
            Param2 = get_param_value(lists:nth(Pointer + 2, List), Param2Mode, List),
            OutputKey = lists:nth(Pointer + 3, List),
            case Param1 == Param2 of
                true ->
                    OutputValue = 1;
                false ->
                    OutputValue = 0
            end,
            intcode(lists:sublist(List,OutputKey) ++ [OutputValue] ++ lists:nthtail(OutputKey + 1, List),Pointer + 4)
        end.

decode_opcode(Opcode) ->
    Opcode_list = lists:map(fun(X) -> X-48 end, integer_to_list(Opcode)),
    case length(Opcode_list) of
        4 ->
            Op = lists:last(Opcode_list) + (lists:nth(length(Opcode_list) - 1, Opcode_list) * 10),
            Param1Mode = lists:nth(2,Opcode_list),
            Param2Mode = lists:nth(1,Opcode_list),
            {Param2Mode,Param1Mode,Op};
        3 ->
            Op = lists:last(Opcode_list) + (lists:nth(length(Opcode_list) - 1, Opcode_list) * 10),
            Param1Mode = lists:nth(1,Opcode_list),
            {0,Param1Mode,Op};
        2 ->
            Op = lists:last(Opcode_list) + (lists:nth(length(Opcode_list) - 1, Opcode_list) * 10),
            {0,0,Op};
        1 ->
            Op = lists:last(Opcode_list),
            {0,0,Op}
    end.

get_param_value(Param, 0, List) ->
    lists:nth(Param + 1, List);
get_param_value(Param, 1, _) ->
    Param.

readfile(FileName) ->
  {ok, Binary} = file:read_file(FileName),
  lists:map(fun(I) -> list_to_integer(I) end, string:tokens(erlang:binary_to_list(Binary), ",")).

replace_elms([H|T], Second, Third) ->
    [H] ++ [Second] ++ [Third] ++ lists:nthtail(2, T).
