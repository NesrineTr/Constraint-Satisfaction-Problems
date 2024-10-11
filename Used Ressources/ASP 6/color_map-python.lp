% Python interface for Map Coloring ASP solver
%
%   $ clingo color_map_asp-python.lp color_map_asp.pl map_aus.pl --const n=4 -n 0

#script(python)
import re
import clingo

def report_model(m):
    """
        Report model m for a Sudoku with grid_size

        @arg m : clingo.solving.Model (https://potassco.org/clingo/python-api/5.5/clingo/solving.html#clingo.solving.Model)
    """
    # print("type of model: ", type(m))
    # print("Model: ", m)
    # print(m.symbols(shown=True))

    # build a grid (lists of lists) of the sudoku from the model
    painting = []
    for f in m.symbols(shown=True):
        # extract paint/2 symbols in model (https://potassco.org/clingo/python-api/5.5/clingo/symbol.html#clingo.symbol.Symbol)
        if f.name == "paint":
            if f.arguments[0].type == clingo.SymbolType.Function:
                country = f.arguments[0].name
            elif f.arguments[0].type == clingo.SymbolType.String:
                country = f.arguments[0].string
            else:
                print("Problem parsing symbols:", f.arguments[0])
                exit(1)

            color = f.arguments[1].number
            painting.append((country,color))

    print('='*50)
    print(f'Solution {m.number} - Size: {len(m.symbols(shown=True))} - Cost: {m.cost} - Optimal? {m.optimality_proven}')
    
    #print(str(m))  # print the model "as is"
    print('='*50)
    print('Here is one way to color the countries:')
    print(painting)
    #print("\t", '='*50, flush=True)
    pass



def main(prg):
    # prg : clingo.control.Control (https://potassco.org/clingo/python-api/5.4/#clingo.Control)
    # ground both
    prg.ground([('base', [])])

    no_colors = prg.get_const("n").number
    print("Number of colors:", no_colors)

    # solve it and call report_model(m) when a model is found
    prg.solve(on_model=lambda model: report_model(model))
#end.