class Production: Hashable, CustomStringConvertible {
    
    var description: String {
        
        var rhsString = "[ "
        
        for index in 0 ... rhs.count {
            
            if index == marker {
                rhsString.append(". ")
            }
            
            if index < rhs.count {
                rhsString.append("\(rhs[index])")
            }
            
            rhsString.append(" ")
            
        }
        
        rhsString.removeLast()
        rhsString.append("]")
        
        return lhs + " -> \(rhsString)"
        
    }
    
    weak var grammar: Grammar!
    
    let lhs: String
    let rhs: [Symbol]
    var marker = 0
    
    var currentSymbol: Symbol? { marker < rhs.count ? rhs[marker] : nil }
    
    var isReduction: Bool { currentSymbol == nil }
    
    // TODO: Cache denne når den først er funnet, for den vil brukes svært mange ganger.
    var closure: Set<Production> {
        
        var productionClosure: Set<Production> = []
        
        fillClosure(&productionClosure)
        
        return productionClosure
        
    }
    
    init(lhs: String, rhs: [Symbol]) {
        self.lhs = lhs
        self.rhs = rhs
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(lhs)
    }
    
    private init(_ lhs: String, _ rhs: [Symbol], _ marker: Int) {
        self.lhs = lhs
        self.rhs = rhs
        self.marker = marker
    }
    
    private func fillClosure(_ closure: inout Set<Production>) {
        
        if closure.contains(where: {$0 == self} ) {
            return
        }
        
        closure.insert(self)
        
        guard let currentSymbol = currentSymbol, case .nonTerminal(let nonTerminal) = currentSymbol else {
            return
        }
        
        let productions = grammar!.productionsFor(nonTerminal)
        
        productions.forEach {
            $0.fillClosure(&closure)
        }
        
    }
    
    func withAdvancedMarker() -> Production {
        let newProduction = Production(lhs, rhs, marker + 1)
        newProduction.grammar = grammar
        return newProduction
    }
    
    static func == (lhs: Production, rhs: Production) -> Bool {
        return (lhs.lhs == rhs.lhs) && (lhs.rhs == rhs.rhs) && (lhs.marker == rhs.marker)
    }
    
}
