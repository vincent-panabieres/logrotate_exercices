def paradox(tree):
    rock = 0
    step = tree / 2
    tolerance = 1e-9

    while abs(rock - tree) >= tolerance:
        rock += step
        step /= 2
        print(f"Position of the rock: {rock}\nDistance for the step: {step}")

    print("The rock reaches the tree!")

paradox(8)