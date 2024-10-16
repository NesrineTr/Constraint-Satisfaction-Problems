import sys
import shutil
from subprocess import run, PIPE, TimeoutExpired
import os
import tempfile
import json
import time
import argparse


def call_clingo(clingo, input_names, timeout):
    cmd = [
        clingo,
        "--warn=no-atom-undefined",
        "--warn=no-file-included",
        "--warn=no-operation-undefined",
        "--warn=no-global-variable",
        "--outf=2",
    ] + input_names
    start = time.time()
    output = run(cmd, stdout=PIPE, stderr=PIPE, timeout=timeout)
    end = time.time()
    if output.stderr:
        raise RuntimeError(f"ERROR: {output.stderr}")
    return output.stdout, end - start


def get_solutions(output):
    solutions = []
    if not output["Result"].startswith("UNSAT"):
        solutions = [
            w["Value"] for w in output["Call"][len(output["Call"]) - 1]["Witnesses"]
        ]
    return output["Result"], solutions


def test_instance(args, instance):
    # set options
    if args.optimize:
        options = args.encoding + [args.instances + instance, args.dummy + "dummy.lp"]
    else:
        # options = [args.encoding, args.instances + instance, "925"] # max 925 answers

        options = args.encoding + [
            args.instances + instance,
            str(args.nosol),
        ]  # max 925 answers

    # add constants settings if available
    if args.const is not None:
        options += ["--const", args.const]

    # call clingo and get solutions
    stdout, time = call_clingo(args.clingo, options, args.timeout)
    result, solutions = get_solutions(json.loads(stdout))

    # print(result)
    # print(len(solutions))

    # get reference solutions
    inst_sol = instance[:-2] + "json"
    with open(args.solutions + inst_sol, "r") as infile:
        ref_result, ref_solutions = get_solutions(json.load(infile))

    # print(len(ref_solutions))

    # compare solution with reference solution
    if result != ref_result:  # is the same result?
        return False, time
    if solutions == []:  # if unsat then return
        return True, time
    for s in solutions:  # order each answer
        s.sort()
    for s in ref_solutions:
        s.sort()
    if args.optimize:  # if optimize then check membership
        return solutions[-1] in ref_solutions, time
    ref_solutions.sort()  # otherwise check equality
    solutions.sort()
    return solutions == ref_solutions, time


def test(args):
    # read instances and sort them
    instances_dir = os.listdir(args.instances)
    instances_dir.sort()
    # loop over instances
    success = True
    for instance in instances_dir:
        message = f"{instance}: "
        try:
            result, time = test_instance(args, instance)
            if result:
                message += f"success in {time:.3f} seconds\n"
            else:
                success = False
                message += f"failure in {time:.3f} seconds\n"
        except Exception as e:
            success = False
            if isinstance(e, TimeoutExpired):
                message += "failure: timeout\n"
            else:
                message += f"failure: error: {str(e)}\n"
    return success, message


def parse():
    parser = argparse.ArgumentParser(description="Test ASP encodings")
    parser.add_argument(
        "--encoding",
        "-e",
        nargs="+",
        metavar="<file>",
        help="ASP encodings to test",
        required=True,
    )
    parser.add_argument(
        "--timeout",
        "-t",
        metavar="N",
        type=int,
        help="Time allocated to each instance",
        required=True,
    )
    parser.add_argument(
        "--nosol",
        "-n",
        metavar="N",
        type=int,
        default=0,
        help="Number of solutions",
        required=False,
    ),
    parser.add_argument(
        "--const",
        metavar="<constants>",
        type=str,
        default=None,
        help="Set constants",
        required=False,
    )
    parser.add_argument(
        "--instances",
        "-i",
        metavar="<path>",
        help="Directory of the instances",
        default="asp/instances/",
        required=False,
    )
    parser.add_argument(
        "--solutions",
        "-s",
        metavar="<path>",
        help="Directory of the solutions",
        default="asp/solutions/",
        required=False,
    )
    parser.add_argument(
        "--clingo",
        "-c",
        metavar="<path>",
        help="Clingo binary",
        default="clingo",
        required=False,
    )
    parser.add_argument(
        "--optimize",
        "-opt",
        action="store_const",
        const=True,
        help="Use this option for optimization problems",
        default=False,
        required=False,
    )
    parser.add_argument(
        "--dummy",
        "-d",
        metavar="<dir>",
        help="Path to dummy.lp. Necessary for optimization problems",
        default="asp/",
        required=False,
    )
    args = parser.parse_args()

    if shutil.which(args.clingo) is None:
        raise IOError("file %s not found!" % args.clingo)

    for f_encoding in args.encoding:
        if not os.path.isfile(f_encoding):
            raise IOError("file %s not found!" % f_encoding)
    if not os.path.isdir(args.instances):
        raise IOError("directory %s not found!" % args.instances)
    if not os.path.isdir(args.solutions):
        raise IOError("directory %s not found!" % args.solutions)
    if args.instances[-1] != "/":
        args.instances += "/"
    if args.solutions[-1] != "/":
        args.solutions += "/"
    return args


def main():
    if sys.version_info < (3, 5):
        raise SystemExit("ERROR: This program requires Python 3.5 or higher")
    try:
        success, message = test(parse())
        if success:
            message += "SUCCESS\n"
            print(message)
            return 0
        else:
            message += "FAILURE\n"
            print(message)
            return 1
        sys.stdout.write(message)

    except Exception as e:
        print(f"ERROR: {str(e)}\n")
        return 1


if __name__ == "__main__":
    sys.exit(main())
