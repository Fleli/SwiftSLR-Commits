
let input =
    """
    Program -> #$init Statements #$end
    Statements -> Statement
    Statements -> Statements Statement
    Statement -> Func
    Statement -> Decl
    Func -> #func #identifier
    Decl -> #var #identifier #= Expr
    Expr -> Expr #+ Term
    Expr -> Term
    Term -> #identifier
    Term -> #integer
    """

try Generator.generate(from: input, includingToken: false)
