%%%-------------------------------------------------------------------
%% @doc day4 public API
%% @end
%%%-------------------------------------------------------------------

-module(day4).

-export([count_valid_passwords_in_range/2, is_valid_password/1]).

count_valid_passwords_in_range(Lower, Upper) ->
    count_valid_passwords_in_range(Lower, Upper, 0).
count_valid_passwords_in_range(Upper, Upper, Count) ->
    Count;
count_valid_passwords_in_range(Current, Upper, Count) ->
    case is_valid_password(Current) of
        true -> count_valid_passwords_in_range(Current + 1, Upper, Count + 1);
        false -> count_valid_passwords_in_range(Current + 1, Upper, Count)
    end.

is_valid_password(Password) ->
    List = integer_to_list(Password),
    is_valid_password(lists:nth(1,List),lists:nth(2,List),lists:nth(3,List),lists:nth(4,List),lists:nth(5,List),lists:nth(6,List)).
is_valid_password(P1,P2,P3,P4,P5,P6) when (P1 > P2) or (P2 > P3) or (P3 > P4) or (P4 > P5) or (P5 > P6) or 
                                        (not ((P1==P2) or (P2==P3) or (P3==P4) or (P4==P5) or (P5==P6))) ->
    false;
is_valid_password(_,_,_,_,_,_) ->
    true.

%% internal functions
