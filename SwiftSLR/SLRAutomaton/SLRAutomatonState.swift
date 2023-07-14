class SLRAutomatonState: Hashable {
    
    private weak var slrAutomaton: SLRAutomaton!
    
    var id = -1
    let productions: [Production]
    
    private var transitions: [SLRAutomatonTransition] = []
    
    private var didGenerate = false
    
    init(_ slrAutomaton: SLRAutomaton, from initialProduction: Production) {
        
        self.slrAutomaton = slrAutomaton
        self.productions = initialProduction.closure
        
        slrAutomaton.addState(self)
        
    }
    
    init(_ slrAutomaton: SLRAutomaton, from closure: [Production]) {
        
        self.slrAutomaton = slrAutomaton
        self.productions = closure
        
        slrAutomaton.addState(self)
        
    }
    
    func generateFullSLRAutomaton() {
        
        if (didGenerate) {
            return
        }
        
        didGenerate = true
        
        productions.forEach {
            propagateAutomatonGeneration(with: $0)
        }
        
    }
    
    private func propagateAutomatonGeneration(with production: Production) {
        
        guard let transitionSymbol = production.currentSymbol else {
            return
        }
        
        let otherState = slrAutomaton.fetchState(with: production.withAdvancedMarker())
        otherState.generateFullSLRAutomaton()
        
        let transition = SLRAutomatonTransition(self, otherState, transitionSymbol)
        transitions.append(transition)
        
    }
    
    func print(with indentation: Int) {
        
        let prefix = String(repeating: "\t", count: indentation)
        
        Swift.print(prefix + "State \(id) {\n")
        
        Swift.print(prefix + "\tClosure {\n")
        
        productions.forEach {
            Swift.print(prefix + "\t\t\($0)")
        }
        
        Swift.print("\n" + prefix + "\t} Transitions {\n")
        
        transitions.forEach {
            Swift.print(prefix + "\t\t\($0)")
        }
        
        Swift.print(prefix + "\n\t\(prefix)}\n")
        
    }
    
}
