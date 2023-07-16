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
                        state_\(newState)()
                        continue
                    }
                
        
        """
        
    }
    
    
    static func reduce(_ number: Int, to nonTerminal: String) -> String {
        
        return """
                    reduce(\(number), to: "\(nonTerminal)")
                
        
        """
        
    }
    
    
    static func goto(_ newState: Int, ifTopOfStackIs nonTerminal: String) -> String {
        
        return """
                    if topOfStackIsNonTerminal("\(nonTerminal)") {
                        state_\(newState)()
                        continue
                    }
                
        
        """
        
    }
    
    
}
