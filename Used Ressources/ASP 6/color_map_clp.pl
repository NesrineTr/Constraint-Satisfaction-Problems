/** Generic map coloring solver via CLPFD library for constraints

@author <your name & student no>
@license GPL
*/
:- use_module(library(clpfd)).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TOP-LEVEL FRAMEWORK - DO NOT CHANGE!!
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% iteratively try number of colors until solution is found, then report
paint_map :-
    between(1, 10, N),
    format("Trying to solve the problem with ~d colors...~n", N),
    paint_map(N), !.
paint_map(N) :-
    solution(Sol, N),
    print_country_colors(Sol).

% Sol2 is a coloring solution with N colors
solution(Sol2, N) :-
    create_variables(Sol, N),
    length(Sol, NoCountries),
    format("Variables generated for ~d countries with ~d colors~n", [NoCountries, N]),
    constrain_variables(Sol), !,
    writeln("All constraints posted!"),
    solve_constraints(Sol),
    num_to_color(Sol, Sol2).

solve_constraints(Sol) :-
    extract_color_vars(Sol, Vars),
    labeling([enum,ff], Vars).

% map the numbering color to real colors via color/2
num_to_color(Sol, Sol2) :-
    findall(col(Country, Color), (member(col(Country, N), Sol), color(N, Color)), Sol2).

% The available colors
color(X) :- color(_, X).
color(1, red).
color(2, white).
color(3, blue).
color(4, yellow).
color(5, violet).
color(6, cyan).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% THIS IS WHAT NEEDS TO BE DEVELOPED!!!
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% L is a list of terms col(Country, Color) where Color can be any color 1..N
%
% first, using findall/3, create the list L where Color are all variables (for each country)
% second, with bagof/3, collect all such color variables in a list Vars
% third, use ins/2 to restrict the domain of each variable to 1..N
create_variables(L, N) :- true.

% Post the constraints for map coloring on the list of col(Country, Color) terms
%   there are many ways to do this, but it is doable in less than 20 lines
constrain_variables(L) :- true.









%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TOOLS - DO NOT CHANGE!!
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% prints the colors of countries in a list with terms col(Country, Color)
print_country_colors([]).
print_country_colors([col(Country, Color)|L]) :-
    print_country_color(Country, Color),
    print_country_colors(L).

print_country_color(Country, Color) :-
    format("Country ~w is colored ~w~n", [Country, Color]).

% get number of countries in the database
no_countries(N) :- findall(C, country(C), X), length(X, N).


% Extract the list of Color variables from a solution template having col(Country, Color)
extract_color_vars(L, Vars) :-
    bagof(V, C^member(col(C, V), L), Vars).
