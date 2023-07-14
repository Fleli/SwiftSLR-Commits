class SLRAutomaton {
    
    private static var currentStateID = 0
    
    private let grammar: Grammar
    
    private var states: [SLRAutomatonState] = []
    
    init(_ grammar: Grammar) {
        
        self.grammar = grammar
        
        let initialProduction = grammar.initialProduction
        let entryState = SLRAutomatonState(self, from: initialProduction)
        
        entryState.generateFullSLRAutomaton()
        
    }
    
    func addState(_ newState: SLRAutomatonState) {
        
        states.append(newState)
        
        newState.id = Self.currentStateID
        Self.currentStateID += 1
        
    }
    
    func fetchState(with initialProduction: Production) -> SLRAutomatonState {
        
        let closure = initialProduction.closure
        
        if let existingState = findState(with: closure) {
            return existingState
        }
        
        let newState = SLRAutomatonState(self, from: closure)
        
        return newState
        
    }
    
    func print() {
        
        Swift.print("SLR Automaton {")
        
        grammar.print(with: 1)
        
        Swift.print("\tStates {\n")
        
        states.forEach { $0.print(with: 2) }
        
        Swift.print("\t}\n\n}")
        
    }
    
    // TODO: La denne huske tidligere resultater (i en dictionary) slik at den etter hvert blir O(1) i stedet for O(n) for n productions.
    private func findState(with closure: [Production]) -> SLRAutomatonState? {
        
        let filtered = states.filter { $0.productions == closure }
        
        // Vil en feil her bety at grammatikken som er gitt ikke er LR-parseable?
        // TODO: Undersøk nærmere ...
        assert(filtered.count < 2, "Expected < 2 matching productions, but found \(filtered.count): \(filtered)")
        
        return filtered.first
        
    }
    
}
