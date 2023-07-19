
let input =
    """
    Program -> Statements #$end
    Statements -> Statements Statement
    Statements -> Statement
    Statement -> Func
    Statement -> Declaration
    Declaration -> #var #identifier #= Expr
    Func -> #func #identifier Closure
    Closure -> #{ Statement #}
    Expr -> Expr #+ Term
    Expr -> Expr #- Term
    Expr -> Term
    Term -> Term #* Factor
    Term -> Term #/ Factor
    Term -> Term #% Factor
    Term -> Factor
    Factor -> #identifier
    Factor -> #integer
    Factor -> #- Factor
    Factor -> #( Expr #)
    """
    /*"""
    P -> S #$end
    S -> V #= E
    S -> E
    E -> E #+ V
    E -> V
    V -> #identifier
    V -> #* E
    """*/

try Generator.generate(from: input, includingToken: false, location: "/Users/frederikedvardsen/Desktop/", fileName: "parsefile")
