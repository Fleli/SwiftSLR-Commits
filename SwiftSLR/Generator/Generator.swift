class Generator {
    
    static func generate(from input: String, includingToken: Bool) throws {
        
        let productions = try interpretInput(input)
        
        let grammar = createGrammarFrom(productions)
        
        grammar.calculateFirstAndFollowSets()
        
        let automaton = SLRAutomaton(grammar)
        
        automaton.print()
        
        let code = SwiftGenerator.generate(from: automaton, includingToken, grammar)
        
        print(code)
        
    }
    
    private static func createGrammarFrom(_ productions: [Production]) -> Grammar {
        
        guard (productions.count > 0) else {
            fatalError("No productions.")
        }
        
        let grammar = Grammar(productions[0])
        
        for index in 1 ..< productions.count {
            grammar.addProduction(productions[index])
        }
        
        return grammar
        
    }
    
}
