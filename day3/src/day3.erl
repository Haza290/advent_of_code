%%%-------------------------------------------------------------------
%% @doc day3 public API
%% @end
%%%-------------------------------------------------------------------

-module(day3).
-export([start/0, get_closes_cross/1, get_all_cross_points/2, get_all_points/1, get_points_from_move/2, readfile/1]).

start() ->
    get_closes_cross(readfile(input)).

get_closes_cross(Lines) ->
    {Line1, Line2} = Lines,
    lists:min(lists:map(fun({X,Y}) -> abs(X) + abs(Y) end, get_all_cross_points(Line1, Line2))).

get_all_cross_points(Line1, Line2) ->
    Line1Points = get_all_points(Line1),
    Line2Points = get_all_points(Line2),
    lists:filter(fun(Elm) -> lists:member(Elm, Line2Points) end, Line1Points).

get_all_points(Line) ->
    get_all_points(Line, [], {0,0}).
get_all_points([], Points, _) ->
    Points;
get_all_points([H|T], Points, Pos) ->
    [NewPos|NewPoints] = get_points_from_move(H, Pos),
    get_all_points(T, [NewPos|NewPoints] ++ Points, NewPos).
    
get_points_from_move(Move, Pos) ->
    get_points_from_move(string:sub_string(Move,1,1), erlang:list_to_integer(lists:nthtail(1,Move)), Pos, []).
get_points_from_move(_, 0, _, List) ->
    List;
get_points_from_move(Direction, Amount, {X,Y}, List) ->
    case Direction of
        "R" -> NewPos = {X + 1, Y};
        "L" -> NewPos = {X - 1, Y};
        "U" -> NewPos = {X, Y + 1};
        "D" -> NewPos = {X, Y - 1}
    end,
    get_points_from_move(Direction, Amount - 1, NewPos, [NewPos|List]).

readfile(FileName) ->
  {ok, Binary} = file:read_file(FileName),
  [Line1, Line2] = string:tokens(erlang:binary_to_list(Binary), "\n"),
  {string:tokens(Line1, ","), string:tokens(Line2, ",")}.


%% internal functions
