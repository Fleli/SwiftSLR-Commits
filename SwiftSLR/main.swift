
let input =
    """
    Program -> #$init Statements
    Statements -> Statements Statement
    Statements -> Statement
    Statement -> #var
    Statement -> #func Closure
    Closure -> #{ Statement #}
    """

try Generator.generate(from: input, includingToken: false)
