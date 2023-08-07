
let input =
    """
    Program -> StatementList
    
    StatementList -> StatementList Statement
    StatementList -> Statement
    
    Statement -> Enum
    Statement -> Nested
    
    Enum -> #enum #identifier #{ EnumList #}
    
    EnumList -> EnumList EnumCase
    EnumList -> EnumCase
    
    EnumCase -> #case #terminal
    EnumCase -> #case #nonTerminal
    
    Nested -> #nested #identifier #{ NestList #}
    
    NestList -> NestList NestCase
    NestList -> NestCase
    
    NestCase ->
    
    """

try Generator.generate(from: input, includingToken: false, location: "/Users/frederikedvardsen/Desktop/", parseFile: "parsefile")
