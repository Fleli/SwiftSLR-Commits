class SwiftGenerator {
    
    
    static func generate(from slrAutomaton: SLRAutomaton, _ includingToken: Bool, _ grammar: Grammar) -> String {
        
        return """
        
        \(SwiftLibrary.slrClass(generateFunctions(for: slrAutomaton, grammar), grammar))
        
        \(SwiftLibrary.typesInFile(includingToken))
        
        """
        
    }
    
    
    private static func generateFunctions(for slrAutomaton: SLRAutomaton, _ grammar: Grammar) -> String {
        
        var functions: String = ""
        
        for state in slrAutomaton.states {
            
            let function = generateFuncFor(state, grammar)
            functions.append(function)
            
        }
        
        return functions
        
    }
    
    
    private static func generateFuncFor(_ state: SLRAutomatonState, _ grammar: Grammar) -> String {
        
        var function = "\tprivate func state_\(state.id)() {\n\n"
        
        function += "\t\tprint(\"In state \(state.id)\")\n\n"
        
        function += reduceStatement(state, grammar)
        
        for transition in state.transitions where transition.transitionSymbol.isNonTerminal {
            function += statement(for: transition)
        }
        
        for transition in state.transitions where !transition.transitionSymbol.isNonTerminal {
            function += statement(for: transition)
        }
        
        function += """
            }
            
        
        """
        
        return function
        
    }
    
    
    private static func statement(for transition: SLRAutomatonTransition) -> String {
        
        let newState = transition.newState.id
        let transitionSymbol = transition.transitionSymbol
        
        switch transitionSymbol {
            
        case .terminal(let type):
            
            return SwiftLibrary.shiftIfTopOfStack(is: type, to: newState)
            
        case .nonTerminal(let nonTerminal):
            
            return SwiftLibrary.goto(newState, ifTopOfStackIs: nonTerminal)
            
        }
        
    }
    
    
    private static func reduceStatement(_ state: SLRAutomatonState, _ grammar: Grammar) -> String {
        
        let reducingProductions = state.productions.filter { $0.isReduction }
        let reduceCount = reducingProductions.count
        
        if (reduceCount > 1) {
            print("The grammar contains a REDUCE/REDUCE conflict:")
            print("Erroneous state: \(state.id)")
            reducingProductions.forEach { print($0) }
            fatalError()
        }
        
        var string = ""
        
        if let first = reducingProductions.first {
            
            string += SwiftLibrary.reduce(first, grammar) + "\n"
            
        }
        
        return string
        
    }
    
    
}
