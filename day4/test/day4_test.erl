-module(day4_test).
-include_lib("eunit/include/eunit.hrl").

valid_password_pass_1_test() ->
    ?assert(day4:is_valid_password(111111)).

valid_password_pass_2_test() ->
    ?assert(day4:is_valid_password(123455)).

invalid_descending_password_test() ->
    ?assertNot(day4:is_valid_password(112136)).

invalid_no_duplicate_password_test() ->
    ?assertNot(day4:is_valid_password(123456)).


