% Define the available colors (1 through n)
color(1..10).

% Each country must have exactly one color
{ paint(C, CC) : color(CC) } = 1 :- country(C).

% No two adjacent countries can have the same color
:- share_border(C1, C2), paint(C1, Color), paint(C2, Color).

% Output directives to simplify the output
#show paint/2.

