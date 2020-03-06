-module(day5_test).
-include_lib("eunit/include/eunit.hrl").

decode_opcode_1_test() ->
    ?assertEqual({1,0,2}, day5:decode_opcode(1002)).

decode_opcode_2_test() ->
    ?assertEqual({1,1,1}, day5:decode_opcode(1101)).

decode_opcode_3_test() ->
    ?assertEqual({0,0,2}, day5:decode_opcode(2)).

intcode_simple_add_test() ->
    ?assertEqual([1,3,2,1,99], day5:intcode([1,1,2,1,99])).

intcode_simple_multiple_test() ->
    ?assertEqual([2,2,6,2,99], day5:intcode([2,2,3,2,99])).

intcode_test() ->
    ?assertEqual([2,11,6,2,4,2,1101,4,7,1,99], day5:intcode([2,2,3,2,4,2,1101,4,7,1,99])).

get_param_value_1_test() ->
    ?assertEqual(1 , day5:get_param_value(0,0,[1,2,3])).

get_param_value_2_test() ->
    ?assertEqual(2 , day5:get_param_value(1,0,[1,2,3])).

get_param_value_3_test() ->
    ?assertEqual(3 , day5:get_param_value(2,0,[1,2,3])).