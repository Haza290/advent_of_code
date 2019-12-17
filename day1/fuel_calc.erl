-module(fuel_calc).
-export([run/1]).
    

run(FileName) ->
    get_fuel_needed(readfile(FileName)).

get_fuel_needed(List) ->
    get_fuel_needed(List, 0).   
get_fuel_needed([], Fuel) ->
    Fuel;
get_fuel_needed([H|T], Fuel) ->
    get_fuel_needed(T, Fuel + fuel_for_part(list_to_integer(H))).

readfile(FileName) ->
  {ok, Binary} = file:read_file(FileName),
  string:tokens(erlang:binary_to_list(Binary), "\n").

fuel_for_part(Mass) ->
    fuel_for_part(mass_to_fuel(Mass), 0).
fuel_for_part(ExtraFuel, Fuel) when ExtraFuel =< 0 ->
    Fuel;
fuel_for_part(ExtraFuel, Fuel) ->
    fuel_for_part(mass_to_fuel(ExtraFuel), Fuel + ExtraFuel).

mass_to_fuel(Mass) ->
    floor((Mass / 3)) - 2.