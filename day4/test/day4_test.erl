-module(day4_test).
-include_lib("eunit/include/eunit.hrl").

valid_password_pass_1_test() ->
    ?assert(day4:is_valid_password(335689)).

valid_password_pass_2_test() ->
    ?assert(day4:is_valid_password(123455)).

valid_password_multi_double_test() ->
    ?assert(day4:is_valid_password(112233)).

valid_password_double_and_triple_test() ->
    ?assert(day4:is_valid_password(111233)).

invalid_descending_password_test() ->
    ?assertNot(day4:is_valid_password(112136)).

invalid_no_duplicate_password_test() ->
    ?assertNot(day4:is_valid_password(123456)).

invalid_no_duplicate_with_triple_password_test() ->
    ?assertNot(day4:is_valid_password(111234)).