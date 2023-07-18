class SLRTable {
    
    typealias SLRTableRow = [Symbol : SLRAction]
    
    var table: [SLRTableRow] = []
    
    let automaton: SLRAutomaton
    
    init(_ slrAutomaton: SLRAutomaton) {
        
        self.automaton = slrAutomaton
        
        automaton.states.forEach { register($0) }
        
    }
    
    func register(_ state: SLRAutomatonState) {
        
        table.append([:])
        
        // Må finne conflicts
        // og løse disse med FIRST/FOLLOW
        
        // krever selvsagt at FIRST/FOLLOW finnes tidligere
        // og at grammaren føres videre inn til tabellen.
        
    }
    
}
