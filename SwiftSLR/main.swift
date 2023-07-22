
let input =
    """
    Program -> StatementList
    StatementList -> StatementList Statement
    StatementList -> Statement
    Statement -> Func
    Statement -> Decl
    Func -> #func #identifier #{ StatementList #}
    Decl -> #var #identifier #= #identifier #;
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

try Generator.generate(from: input, includingToken: false, location: "/Users/frederikedvardsen/Desktop/", parseFile: "parsefile", typeFilePrefix: "Type_")
