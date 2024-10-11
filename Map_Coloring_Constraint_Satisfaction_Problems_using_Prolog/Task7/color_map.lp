
% Relations de frontière entre les pays
share_border(C1, C2) :- border_datum(_, C1, _, C2).
share_border(C1, C2) :- border_datum(_, C2, _, C1).

% Relations de frontière symétriques
share_border(X, Y) :- share_border(Y, X).

%country(C) :- border_datum(_, C, _,_).
% Define the available colors (1 through n)
color(1..n).


% Each country must have exactly one color
{ paint(C, CC) : color(CC) } = 1 :- country(C).

% No two adjacent countries can have the same color
:- share_border(C1, C2), paint(C1, Color), paint(C2, Color).

#show paint/2.
#show no_countries/1.



