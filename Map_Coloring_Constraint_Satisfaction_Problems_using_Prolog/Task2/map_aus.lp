

color(1..n).

% Map from Hector Levesque's Thinking as Computation book
country("WA").
country("NT").
country("SA").
country("QLD").
country("NSW").
country("VIC").
country("TAS").
country("ACT").


share_border(C1, C2) :- share_border(C2, C1).    % symetric relation
share_border("WA", ("NT"; "SA")).
share_border("NT", ("WA"; "SA";"QLD")).
share_border("SA", ("VIC"; "NSW"; "QLD";"NT";"WA")).
share_border("QLD", ("NSW"; "SA"; "NT")).
share_border("NSW", ("VIC"; "ACT")).
share_border("VIC", ("NSW")).
share_border("ACT", ("NSW")).
share_border("TAS").