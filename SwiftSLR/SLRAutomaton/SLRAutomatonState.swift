class SLRAutomatonState: Hashable, CustomStringConvertible {
    
    var description: String {
        return "\(id)"
    }
    
    private weak var slrAutomaton: SLRAutomaton!
    
    var id = -1
    var productions: Set<Production>
    
    var transitions: Set<SLRAutomatonTransition> = []
    
    var isReducing: Bool { productions.filter {$0.isReduction} .count > 0 }
    var isShifting: Bool { productions.filter {$0.isShift} .count > 0 }
    
    var isShiftReduceConflict: Bool { isReducing && isShifting }
    
    private var didGenerate = false
    
    private var stateCache: [Symbol : SLRAutomatonState] = [:]
    
    convenience init(_ slrAutomaton: SLRAutomaton, from initialProduction: Production) {
        
        let closure = initialProduction.closure
        
        self.init(slrAutomaton, from: closure)
        
    }
    
    init(_ slrAutomaton: SLRAutomaton, from closure: Set<Production>) {
        
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
        
        let otherState: SLRAutomatonState
        
        let advancedProduction = production.withAdvancedMarker()
        
        if let cached = stateCache[transitionSymbol] {
            
            otherState = cached
            
            let union = otherState.productions.union(advancedProduction.closure)
            
            if union.count > otherState.productions.count {
                otherState.didGenerate = false
                otherState.productions = union
            }
            
        } else {
            
            otherState = slrAutomaton.fetchState(with: advancedProduction)
            
        }
        
        otherState.generateFullSLRAutomaton()
        
        let transition = SLRAutomatonTransition(self, otherState, transitionSymbol)
        transitions.insert(transition)
        
        stateCache[transitionSymbol] = otherState
        
    }
    
}
