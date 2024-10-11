% Here include all border_datum/4 facts from CSV file found at:
%       https://github.com/geodatasource/country-borders
%
%
%
% You can SWI-Prolog:
%   - read_csv/2 to read the CSV file and build a list of row/4 compound terms, one per row in CSV
%   - findall/3 with atom_string/2 and =../2 to build a list of border_datum/4 terms with arguments as strings, wow!
%   - assert/1 to assert each new border_datum/4 term into the Prolog database (memory)
%   - listing(row/4) to list all border_datum/4 terms in the Prolog database
%   - tell/1 to tell to a file; told/0 to reset to console% Encode here the full world map as per borders in this CSV file:
%       https://github.com/geodatasource/country-borders
%
