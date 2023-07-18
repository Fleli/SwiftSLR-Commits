
let input =
    """
    Program -> #$init Statements #$end
    Statements -> Statement
    Statements -> Statements Statement
    Statement -> Func
    Statement -> Decl
    Closure -> #{ Statements #}
    Func -> #func #identifier Closure
    Decl -> #var #identifier #= Expr
    Decl -> #var #identifier #: #identifier #= Expr
    Expr -> Expr #+ Term
    Expr -> Term
    Term -> #identifier
    Term -> #integer
    """

try Generator.generate(from: input, includingToken: false)
