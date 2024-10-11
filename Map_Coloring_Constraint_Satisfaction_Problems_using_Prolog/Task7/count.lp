% Define the predicate no_countries/1
no_countries(N) :- #count{C : country(C), paint(C, _)} = N.
