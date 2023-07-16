/*
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
*/

for i in 1 ... 100 {
    
    print(String(repeating: "\n", count: 20))
    
    SLRAutomaton.currentStateID = 0
    
    let input =
        """
        S -> E
        E -> E #+ T
        E -> T
        T -> T #* F
        T -> F
        F -> #id
        """
    
    try Generator.generate(from: input, includingToken: true)
    
    print("Generated \(i)")

}
