load("curve.sage")

def quadRes(x, q):
    return pow(x, (q + 1) / 4, q)

def g1XToYSquared(x):
    return pow(x, 3, q) + g1b

# todo: Add hash function support, so this can be tested
def tryAndIncrementEvm(message):
    counter = 0
    px = 0
    py = 0
    while(True):
        h = hash(bytes([counter]) + message)
        counter += 1
        px = bin(abs(h))[2:]
        px = int(px[:32*8])
        px = px % q
        ySqr = g1XToYSquared(px)
        root = quadRes(ySqr, q)
        rootSqr = pow(root, 2, q)
        if rootSqr == ySqr:
            py = root
            counter = 255
            signY = hash(bytes([counter]) + message) % 2
            if signY == 1:
                py = q - py
            break
    return px, py
