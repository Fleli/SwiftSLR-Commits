
let input =
    """
    Program -> Declaration
    Visibility -> #private
    Visibility -> #public
    Type -> #identifier
    Declaration -> #identifier
    Declaration -> #identifier Type
    Declaration -> Visibility #identifier
    Declaration -> Visibility #identifier Type
    
    """

try Generator.generate(from: input, includingToken: false, location: "/Users/frederikedvardsen/Desktop/", parseFile: "parsefile")
