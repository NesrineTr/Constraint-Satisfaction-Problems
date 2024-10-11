:- ['map_world_datum.lp'].

country(C) :-
    country_datum(C, _).

share_border(C1, C2) :-
    border_datum(_, C1, _, C2),
    C2 \= "".
