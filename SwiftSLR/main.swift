
let input =
    """
    Program -> StatementList
    
    StatementList -> StatementList Statement
    StatementList -> Statement
    
    Statement -> Declaration
    
    Declaration -> DeclarationPrefix #identifier #: Type #;
    Declaration -> DeclarationPrefix #identifier #: Type #= Expression #;
    Declaration -> DeclarationPrefix #identifier #= Expression #;
    
    DeclarationPrefix -> #var
    DeclarationPrefix -> #let
    
    Type -> #identifier
    Type -> Type #-> Type
    
    Expression -> #integer
    """

try Generator.generate(from: input, includingToken: false, location: "/Users/frederikedvardsen/Desktop/", parseFile: "parsefile")
