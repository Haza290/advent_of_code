-module(day3_test).
-include_lib("eunit/include/eunit.hrl").


get_closes_cross_1_test() ->
    ?assertEqual(159, day3:get_closes_cross(
        {["R75","D30","R83","U83","L12","D49","R71","U7","L72"],
        ["U62","R66","U55","R34","D71","R55","D58","R83"]})).

get_closes_cross_2_test() ->
    ?assertEqual(135, day3:get_closes_cross(
        {["R98","U47","R26","D63","R33","U87","L62","D20","R33","U53","R51"],["U98","R91","D20","R16","D67","R40","U7","R15","U6","R7"]})).

get_all_cross_points_1_test() ->
    ?assertEqual([{2,2},{1,1}], day3:get_all_cross_points(["U1","R2","U1"], ["R1","U2","R1"])).
get_all_cross_points_2_test() ->
    ?assertEqual([{3,-4},{2,-1}], day3:get_all_cross_points(["D1","R3","D7"], ["R2","D4","R6"])).

get_all_points_test() ->
    ?assertEqual([{2,3},{2,4},{2,5},{3,5},{3,4},{3,3},{3,2},{3,1},{3,0},{2,0},{1,0}], day3:get_all_points(["R3","U5","L1","D2"])).

get_points_from_move_right_test() ->
    ?assertEqual([{6,5},{5,5},{4,5}], day3:get_points_from_move("R3", {3,5})).
get_points_from_move_left_test() ->
    ?assertEqual([{-3,4},{-2,4},{-1,4},{0,4}], day3:get_points_from_move("L4", {1,4})).
get_points_from_move_up_test() ->
    ?assertEqual([{3,6}], day3:get_points_from_move("U1", {3,5})).
get_points_from_move_down_test() ->
    ?assertEqual([{8,-5},{8,-4}], day3:get_points_from_move("D2", {8,-3})).