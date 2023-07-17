enum Symbol: Hashable, CustomStringConvertible {
    
    case terminal(String)
    case nonTerminal(String)
    
    var description: String {
        switch self {
        case .terminal(let string):
            return "T(\(string))"
        case .nonTerminal(let string):
            return "N(\(string))"
        }
    }
    
    var isNonTerminal: Bool {
        return description.first! == "N"
    }
    
}
