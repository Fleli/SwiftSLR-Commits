
let input =
    """
    Program -> #$init Statements
    Statements -> Statements Statement
    Statements -> Statement
    Statement -> Func
    Statement -> Declaration
    Declaration -> #var #identifier #= Expr
    Func -> #func #identifier Closure
    Closure -> #{ Statement #}
    Expr -> Expr #+ Term
    Expr -> Term
    Term -> Term #* Factor
    Term -> Factor
    Factor -> #identifier
    Factor -> #integer
    """

try Generator.generate(from: input, includingToken: false)
