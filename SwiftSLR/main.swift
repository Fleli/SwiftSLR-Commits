
let input =
    """
    S -> N(E)
    E -> T(x) T(y)
    """

try Generator.generate(from: input)
