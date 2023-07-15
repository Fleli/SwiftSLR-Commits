
let input =
    """
    S -> N(E)
    E -> N(T) T(+) N(E)
    E -> N(T)
    T -> T(x)
    """

try Generator.generate(from: input)
