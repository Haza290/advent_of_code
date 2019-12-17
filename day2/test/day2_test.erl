-module(day2_test).
-include_lib("eunit/include/eunit.hrl").

add_test() ->
    day2:intcode([1,0,0,0,99]) == 2.

multiple_test() ->
    day2:intcode([2,3,0,0,99]) == 6.

smiple_test() ->
    day2:intcode([1,1,1,4,99,5,6,0,99]) == 30.

complex_test() ->
    day2:intcode([1,9,10,3,2,3,11,0,99,30,40,50]) == 3500.