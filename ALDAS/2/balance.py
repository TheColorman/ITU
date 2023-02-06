class Node():
    def __init__(self) -> None:
        self.item = None
        self.next = None

class Stack:
    def __init__(self) -> None:
        self.first = None
        self.n = 0
    
    def push(self, item):
        oldfirst = self.first
        self.first = Node()
        self.first.item = item
        self.first.next = oldfirst
        self.n += 1

    def pop(self):
        oldfirst = self.first
        if oldfirst == None:
            return None
        self.first = oldfirst.next
        self.n -= 1
        return oldfirst.item

line = input()

stack = Stack()
def check():
    for i in line:
        if i in "{[(":
            stack.push(i)
        else:
            last = stack.pop()
            if i == "}" and not last == "{":
                print(0)
                return
            if i == "]" and not last == "[":
                print(0)
                return
            if i == ")" and not last == "(":
                print(0)
                return
    if stack.n > 0:
        print(0)
        return
    print(1)

check()