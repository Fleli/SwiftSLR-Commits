class SLRAutomatonState: Hashable {
    
    private weak var slrAutomaton: SLRAutomaton!
    
    private var productions: [Production]
    
    init(from initialProduction: Production) {
        
        productions = initialProduction.closure
        
    }
    
}
