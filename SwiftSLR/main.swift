
let input =
    """
    Program -> Declaration
    Declaration -> #let List #;
    List -> List #, X
    List -> X
    List ->
    X -> #identifier
    """

try Generator.generate(from: input, includingToken: false, location: "/Users/frederikedvardsen/Desktop/", parseFile: "parsefile")
