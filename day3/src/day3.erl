%%%-------------------------------------------------------------------
%% @doc day3 public API
%% @end
%%%-------------------------------------------------------------------

-module(day3).
-export([start/0, get_lowest_step_cross/2, get_all_cross_points/2, get_all_points/1, get_points_from_move/2, readfile/1]).

start() ->
    {Line1, Line2} = readfile(input),
    get_lowest_step_cross(Line1, Line2).

get_lowest_step_cross(Line1, Line2) ->
    lists:min(lists:map(fun({_,StepCount}) -> StepCount end, get_all_cross_points(Line1, Line2))).

%get_closes_cross(Lines) ->
%    {Line1, Line2} = Lines,
%    lists:min(lists:map(fun({X,Y,_}) -> abs(X) + abs(Y) end, get_all_cross_points(Line1, Line2))).

get_all_cross_points(Line1, Line2) ->
    Line1Points = lists:reverse(get_all_points(Line1)),
    Line2Points = lists:reverse(get_all_points(Line2)),
    Line1CoordinatesSet = sets:from_list(lists:map(fun({Coordinates,_}) -> Coordinates end, Line1Points)),
    Line2CoordinatesSet = sets:from_list(lists:map(fun({Coordinates,_}) -> Coordinates end, Line2Points)),
    CrossCoordinates = sets:to_list(sets:intersection(Line1CoordinatesSet, Line2CoordinatesSet)),
    lists:map(fun(Coordinate) -> {Coordinate, get_first_occurrence(Coordinate, Line1Points) + get_first_occurrence(Coordinate, Line2Points)} end, CrossCoordinates).

get_first_occurrence(Coordinate, [{Coordinate,StepCount}|_]) ->
    StepCount;
get_first_occurrence(Coordinate, [_|T]) ->
    get_first_occurrence(Coordinate, T).

get_all_points(Line) ->
    get_all_points(Line, [], {{0,0},0}).
get_all_points([], Points, _) ->
    Points;
get_all_points([H|T], Points, Pos) ->
    [NewPos|NewPoints] = get_points_from_move(H, Pos),
    get_all_points(T, [NewPos|NewPoints] ++ Points, NewPos).
    
get_points_from_move(Move, Pos) ->
    get_points_from_move(string:sub_string(Move,1,1), erlang:list_to_integer(lists:nthtail(1,Move)), Pos, []).
get_points_from_move(_,0,_,List) ->
    List;
get_points_from_move(Direction, Amount, {{X,Y},StepCount}, List) ->
    case Direction of
        "R" -> NewPos = {{X + 1, Y}, StepCount + 1};
        "L" -> NewPos = {{X - 1, Y}, StepCount + 1};
        "U" -> NewPos = {{X, Y + 1}, StepCount + 1};
        "D" -> NewPos = {{X, Y - 1}, StepCount + 1}
    end,
    get_points_from_move(Direction, Amount - 1, NewPos, [NewPos|List]).

readfile(FileName) ->
  {ok, Binary} = file:read_file(FileName),
  [Line1, Line2] = string:tokens(erlang:binary_to_list(Binary), "\n"),
  {string:tokens(Line1, ","), string:tokens(Line2, ",")}.


%% internal functions
