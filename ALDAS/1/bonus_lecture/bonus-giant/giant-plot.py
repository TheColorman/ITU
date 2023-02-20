from giant import giant
import matplotlib.pyplot as plt
from math import log
gnt = [] #[0]
non_is = []# [0]
conn = []# [0]
rep = 100
n = 1000
only_giant = False #True
for i in range(rep):
    g,iso,comp = giant(n,stop_at_giant=only_giant)
    gnt.append(g)
    if not only_giant:
        non_is.append(iso)
        conn.append(comp)
# c = 10
# gnt.append(c*n)
# non_is.append(c*n)
# conn.append(c*n)

fig = plt.figure()
ax = fig.add_subplot( 1, 1, 1)
handles = []
for data,col,what,f in [(gnt,'tab:blue','giant',lambda x:x/n),
                 (non_is,'tab:orange','non isolated',lambda x:x/n),
                 (conn,'tab:green','connected',lambda x:x/n)]:
    handles.append(ax.plot([f(x) for x in sorted(data)], 
            [i/rep for i in range(len(data))], color=col,label=what)[0])
ax.set_xlabel('#edges / n i.e. p n')
ax.set_ylabel('fraction of experiments')
ax.legend(handles=handles)
# ax.set_title('line plot with data points')
# display the plot
plt.show()