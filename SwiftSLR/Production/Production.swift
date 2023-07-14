class Production: Equatable {
    
    weak var grammar: Grammar!
    
    let lhs: String
    let rhs: [Symbol]
    
    var currentSymbol: Symbol? { marker < rhs.count ? rhs[marker] : nil }
    
    var closure: [Production] {
        
        var productionClosure: [Production] = []
        
        fillClosure(&productionClosure)
        
        return productionClosure
        
    }
    
    private var marker = 0
    
    init(lhs: String, rhs: [Symbol]) {
        self.lhs = lhs
        self.rhs = rhs
    }
    
    private init(_ lhs: String, _ rhs: [Symbol], _ marker: Int) {
        self.lhs = lhs
        self.rhs = rhs
        self.marker = marker
    }
    
    private func fillClosure(_ closure: inout [Production]) {
        
        if closure.contains(where: {$0 == self} ) {
            return
        }
        
        closure.append(self)
        
        guard let currentSymbol = currentSymbol, case .nonTerminal(let nonTerminal) = currentSymbol else {
            return
        }
        
        let productions = grammar!.productionsFor(nonTerminal)
        
        productions.forEach {
            $0.fillClosure(&closure)
        }
        
    }
    
    func withAdvancedMarker() -> Production {
        return Production(lhs, rhs, marker + 1)
    }
    
    static func == (lhs: Production, rhs: Production) -> Bool {
        return (lhs.lhs == rhs.lhs) && (lhs.rhs == rhs.rhs) && (lhs.marker == rhs.marker)
    }
    
}
