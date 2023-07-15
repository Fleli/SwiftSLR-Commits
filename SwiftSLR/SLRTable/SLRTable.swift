
typealias SLRTableRow = [Token : SLRAction]

class SLRTable {
    
    
    var table: [SLRTableRow]
    
    
    init(_ slrAutomaton: SLRAutomaton) {
        
        let numberOfStates = slrAutomaton.states.count
        let emptyTableRow = [Token : SLRAction]()
        
        table = [SLRTableRow](repeating: emptyTableRow, count: numberOfStates)
        
        let allStates = slrAutomaton.states
        
        allStates.forEach { state in
            state.fill(self)
        }
        
    }
    
    
}
