enum SwiftLibrary {
    
    // TODO: Skriv følgende hjelpefunksjoner
    //  -   shift()
    //  -   reduce(:to:)
    //  -   topOfStackIsToken(:)
    //  -   topOfStackIsNonTerminal(:)
    
    static func shiftIfTopOfStack(is type: String, to newState: Int) -> String {
        
        return """
                if topOfStackIsToken("\(type)") {
                    shift()
                    pushState(state_\(newState))
                    return
                }
                
        
        """
        
    }
    
    
    static func reduce(_ reducingProduction: Production, _ grammar: Grammar) -> String {
        
        let nonTerminal = reducingProduction.lhs
        let number = reducingProduction.rhs.count
        
        let followSet = grammar.followSets[nonTerminal]!
        
        if followSet.isEmpty {
            
            return """
                    reduce(\(number), to: "\(nonTerminal)")
                    return
                    
            
            """
            
        } else {
            
            let followSetString = "\(followSet)"
            
            return """
                    if topOfStackIsAmong(\(followSetString)) {
                        reduce(\(number), to: "\(nonTerminal)")
                        return
                    }
                    
            
            """
            
        }
        
        
    }
    
    
    static func goto(_ newState: Int, ifTopOfStackIs nonTerminal: String) -> String {
        
        return """
                if topOfStackIsNonTerminal("\(nonTerminal)") {
                    pushState(state_\(newState))
                    return
                }
                
        
        """
        
    }
    
    
}
