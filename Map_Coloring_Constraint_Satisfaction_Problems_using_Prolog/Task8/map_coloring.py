import argparse
import clingo
import time

COLOR_MAP = {
    1: "red",
    2: "green",
    3: "blue",
    4: "yellow",
    5: "purple",
    6: "orange",
    7: "pink",
    8: "brown",
    9: "black",
    10: "white",
}


def on_model(m):
    # print(m)
    painting = []
    for f in m.symbols(shown=True):
        # extract paint/2 symbols in model
        # (https://potassco.org/clingo/python-api/5.5/clingo/symbol.html#clingo.symbol.Symbol)
        if f.name == "paint":
            if f.arguments[0].type == clingo.SymbolType.Function:
                country = f.arguments[0].name
            elif f.arguments[0].type == clingo.SymbolType.String:
                country = f.arguments[0].string
            else:
                print("Problem parsing symbols:", f.arguments[0])
                exit(1)

            color = f.arguments[1].number
            painting.append((country, COLOR_MAP[color]))

    painting.sort(key=lambda x: x[0])
    for x in painting:
        print("Paint country", x[0], "with color", x[1])


if __name__ == "__main__":
    parser: argparse.ArgumentParser = argparse.ArgumentParser(
        description="Python interface to Clingo Map Coloring solver."
    )
    parser.add_argument("map", help="File containing the map.")
    parser.add_argument(
        "--num-colors",
        help="File containing the map (Default: %(default)s)",
        default=2,
        type=int,
    )
    args = parser.parse_args()
    # print(args)

    print(f"Paint map {args.map} with {args.num_colors} colors.")

    start = time.time()

    print("Initiating solver...")
    ctl = clingo.Control(["1"])

    ctl.load("color_map.lp")
    ctl.load(args.map)
    ctl.add(f"color(1..{args.num_colors}).")

    ctl.ground()
    result = ctl.solve(on_model=on_model)

    end = time.time()

    print()
    if result.satisfiable:
        print(f"Map successfully painted with {args.num_colors} colors!")
    else:
        print(f"Sorry, that map cannot be painted with just {args.num_colors} colors.")
    print("Wall time taken:", end - start, "seconds.")
