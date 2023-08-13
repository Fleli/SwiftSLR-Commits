
let input =
    """
    Program -> Main
    Main -> StatementLIST
    StatementLIST -> StatementLIST Statement
    StatementLIST -> Statement
    Statement -> Declaration
    Visibility -> #private
    Visibility -> #public
    Type -> #( TypeLIST #)
    Type -> #identifier
    TypeLIST -> TypeLIST #, Type
    TypeLIST -> Type
    DeclarationKeyword -> #let
    DeclarationKeyword -> #var
    Declaration -> DeclarationKeyword #identifier
    Declaration -> DeclarationKeyword #identifier Type
    Declaration -> Visibility DeclarationKeyword #identifier
    Declaration -> Visibility DeclarationKeyword #identifier Type
    StatementLIST -> StatementLIST  Statement
    StatementLIST -> Statement
    TypeLIST -> TypeLIST #, Type
    TypeLIST -> Type
    """

try Generator.generate(from: input, includingToken: false, location: "/Users/frederikedvardsen/Desktop/", parseFile: "parsefile")
