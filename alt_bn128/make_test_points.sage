load("curve.sage")

number_of_keys = 10
for i in range(number_of_keys):
    x = randrange(0, order)
    print(x, (x*g2).xy())
