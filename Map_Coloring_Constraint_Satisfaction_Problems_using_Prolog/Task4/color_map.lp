% Relations de frontière entre les pays
share_border(C1, C2) :- border_datum(_, C1, _, C2).
share_border(C1, C2) :- border_datum(_, C2, _, C1).

% Relations de frontière symétriques
share_border(X, Y) :- share_border(Y, X).

% Liste des pays
country(C) :- border_datum(_, C, _, _).

% Règles de coloriage
color(1..n).

{ paint(C, CC) : color(CC) } = 1 :- country(C).
:- share_border(C1, C2), paint(C1, Color), paint(C2, Color).

% Output directives to simplify the output
#show paint/2.


