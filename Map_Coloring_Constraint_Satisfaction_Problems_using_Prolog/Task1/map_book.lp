% default no of colors available
#const n = 3.   % DO NOT CHANGE! Override using --const option

color(1..n).

% Map from Hector Levesque's Thinking as Computation book
country(a).
country(b).
country(c).
country(d).
country(e).

share_border(C1, C2) :- share_border(C2, C1).    % symetric relation
share_border(a, (b; c; d; e)).
share_border(b, (a; c)).
share_border(c, (a; b; d)).
share_border(d, (a; c; e)).
share_border(e, (a; d)).


