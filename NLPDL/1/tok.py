import re
import pathlib

regex = re.compile("((?<!\w)'(?=\w|[.,:;()])|(?<=[\w.,:;()])'(?!\w)|(?:D:)|(['@#]?\w+)|\.{3}|[\.!&])")

file = pathlib.Path(__file__).parent.resolve().joinpath('tok.dev.txt')
with open(file, "r", encoding='utf-8') as f:
    lines = f.readlines()

lines = [line.strip().split("\t") for line in lines]

raw = [line[0] for line in lines]
tokens = [[x[0] for x in regex.findall(line)] for line in raw]
result = [" ".join(token) for token in tokens]

output = [raw[i] + "\t" + result[i] + " \n" for i in range(len(result))]
outfile = pathlib.Path(__file__).parent.resolve().joinpath('tok.out.txt')
with open(outfile, "w", encoding="utf-8") as f:
    f.writelines(output)