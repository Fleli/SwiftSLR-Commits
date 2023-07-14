class SLRAutomatonState: Hashable {
    
    private weak var slrAutomaton: SLRAutomaton!
    
    let productions: [Production]
    
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
        
        
        
    }
    
}
