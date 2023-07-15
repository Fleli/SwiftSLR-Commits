class SLRAutomatonTransition: Hashable, CustomStringConvertible {
    
    var description: String { "\(oldState.id) -> \(newState.id) @ \(transitionSymbol)" }
    
    var oldState: SLRAutomatonState
    var newState: SLRAutomatonState
    
    var transitionSymbol: Symbol
    
    init(_ oldState: SLRAutomatonState, _ newState: SLRAutomatonState, _ transitionSymbol: Symbol) {
        self.oldState = oldState
        self.newState = newState
        self.transitionSymbol = transitionSymbol
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(oldState)
        hasher.combine(newState)
    }
    
    static func == (lhs: SLRAutomatonTransition, rhs: SLRAutomatonTransition) -> Bool {
        return (lhs.oldState == rhs.oldState) && (lhs.newState == rhs.newState) && (lhs.transitionSymbol == rhs.transitionSymbol)
    }
    
}
