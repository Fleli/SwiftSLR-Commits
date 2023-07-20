
let input =
    """
    Program -> StatementList                        { $0 }
    StatementList -> StatementList Statement        { $0 $1 }
    StatementList -> Statement                      { $0 }
    Statement -> Func                               { $0 }
    Statement -> Decl                               { $0 }
    Func -> #func #identifier                       { $1 }
    Decl -> #var #identifier #= #identifier #;      { $0 $1 $3 }
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
