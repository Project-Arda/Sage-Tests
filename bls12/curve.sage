# All of these numbers come from https://github.com/ebfull/pairing/blob/ef7ade8c2cd36f0906b2272f12b47871b41f70df/src/bls12_381/README.md
q = 0x1a0111ea397fe69a4b1ba7b6434bacd764774b84f38512bf6730d2a0f6b0f6241eabfffeb153ffffb9feffffffffaaab
F1 = GF(q)
F2 = GF(q^2,"u",modulus=x^2 + 1)
x = -0xd201000000010000
x = x % q
C1 = EllipticCurve(F1,[0,4])
cofactor1 = Integer(pow(x - 1, 2, q) / 3)
g1 = C1(3685416753713387016781088315183077757961620795782546409894578378688607592378376318836054947676345821548104185464507,1339506544944476473020471379941921221584933875938349620426543736416511423956333506472724655353366534992391756441569)
order = C1.order()
assert order % cofactor1 == 0
order = order // cofactor1
identity1 = C1(0, 1, 0)
assert g1*order == identity1

C2 = EllipticCurve(F2,[0,4*F2("1+u")])
cofactor2 = 305502333931268344200999753193121504214466019254188142667664032982267604182971884026507427359259977847832272839041616661285803823378372096355777062779109
g2 = C2(F2("3059144344244213709971259814753781636986470325476647558659373206291635324768958432433509563104347017837885763365758*u + 352701069587466618187139116011060144890029952792775240219908644239793785735715026873347600343865175952761926303160"),
    F2("927553665492332455747201965776037880757740193453592970025027978793976877002675564980949289727957565575433344219582*u + 1985150602287291935568054521177171638300868978215655730859378665066344726373823718423869104263333984641494340347905"))
identity2 = C2(0, 1, 0)
assert g2 * order == identity2
assert C2.cardinality() % order == 0
assert C2.cardinality() % cofactor2 == 0
assert C2.cardinality() // cofactor2 == order