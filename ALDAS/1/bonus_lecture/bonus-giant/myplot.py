import matplotlib.pyplot as plt
from pathlib import Path
import sys

P = Path('.')
fig = plt.figure()
ax = fig.add_subplot( 1, 1, 1)
handles = []
for fileglob in sys.argv[1:]:
    for filename in P.glob(fileglob):
        data = []
        with open(filename) as f:
            data = [float(l) for l in f]
        if data:
            rep = len(data)
            handles.append(ax.plot(data,[i/rep for i in range(rep)],label=filename.stem)[0])  #, color=col,label=what)[0])
ax.set_xlabel('#edges / n i.e. p n')
ax.set_ylabel('fraction of experiments')
ax.legend(handles=handles)
# ax.set_title('line plot with data points')
# display the plot
plt.show()