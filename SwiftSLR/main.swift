
let input =
    """
    S -> Expr
    Expr -> Expr #+ Term
    Expr -> Expr #- Term
    Expr -> Term
    Term -> Term #* Factor
    Term -> Factor
    Factor -> #id
    
    """

try Generator.generate(from: input)
