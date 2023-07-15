

let input =
    """
    S -> N(E)
    E -> T(x) T(+) N(E)
    E -> T(x)
    """

try Generator.generate(from: input)
