while True:
    try:
        string = input()
        if "problem" in string.lower():
            print("yes")
        else:
            print("no")
    except:
        exit()
