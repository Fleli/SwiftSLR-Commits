extension SLRAutomatonState {
    
    func hash(into hasher: inout Hasher) { }
    
    static func == (lhs: SLRAutomatonState, rhs: SLRAutomatonState) -> Bool {
        return lhs.productions == rhs.productions && lhs.id == rhs.id
    }
    
}
