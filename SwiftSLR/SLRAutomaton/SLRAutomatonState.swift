class SLRAutomatonState: Hashable {
    
    private weak var slrAutomaton: SLRAutomaton!
    
    var id = -1
    let productions: [Production]
    
    private var transitions: [SLRAutomatonTransition] = []
    
    private var didGenerate = false
    
    private let isReducing: Bool
    
    convenience init(_ slrAutomaton: SLRAutomaton, from initialProduction: Production) {
        
        let closure = initialProduction.closure
        
        self.init(slrAutomaton, from: closure)
        
    }
    
    init(_ slrAutomaton: SLRAutomaton, from closure: [Production]) {
        
        self.slrAutomaton = slrAutomaton
        self.productions = closure
        
        self.isReducing = productions.filter {$0.isReduction} .count > 0
        
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
        
        let advancedProduction = production.withAdvancedMarker()
        let otherState = slrAutomaton.fetchState(with: advancedProduction)
        otherState.generateFullSLRAutomaton()
        
        let transition = SLRAutomatonTransition(self, otherState, transitionSymbol)
        transitions.append(transition)
        
    }
    
    func print(with indentation: Int) {
        
        let prefix = String(repeating: "\t", count: indentation)
        let isReducingNotification = isReducing ? "(REDUCING)" : ""
        
        Swift.print(prefix + "State \(id) \(isReducingNotification) {")
        
        if (!isReducing) {
            
            Swift.print(prefix + "\tClosure {")
            
            productions.forEach {
                Swift.print(prefix + "\t\t\($0)")
            }
            
            Swift.print(prefix + "\t} Transitions {")
            
            transitions.forEach {
                Swift.print(prefix + "\t\t\($0)")
            }
            
            Swift.print(prefix + "\t}")
            
        } else {
            
            productions.forEach {
                Swift.print(prefix + "\t\($0)")
            }
            
        }
        
        Swift.print(prefix + "}")
        
    }
    
}
