class Grammar {
    
    var initialProduction: Production
    
    var productions: [Production] = []
    
    private var terminals: Set<String> = []
    
    var firstSets: [String : Set<String>] = [:]
    var followSets: [String : Set<String>] = [:]
    
    private var firstSetCount: Int {
        
        var count = 0
        
        firstSets.forEach { count += $0.value.count }
        
        return count
        
    }
    
    init(_ initialProduction: Production) {
        
        self.initialProduction = initialProduction
        
        addProduction(self.initialProduction)
        
    }
    
    func addProduction(_ production: Production) {
        
        production.grammar = self
        productions.append(production)
        
        terminals.formUnion(production.terminals)
        
    }
    
    func productionsFor(_ nonTerminal: String) -> [Production] {
        
        return productions.filter { $0.lhs == nonTerminal }
        
    }
    
    func calculateFirstAndFollowSets() {
        
        productions.forEach {
            firstSets[$0.lhs] = []
            followSets[$0.lhs] = []
        }
        
        calculateFirstSets()
        calculateFollowSets()
        
    }
    
    private func calculateFirstSets() {
        
        var firstSetCounts: [Int] = []
        
        let productionCount = productions.count
        
        var didReachFixedPoint: Bool {
            
            let lastIndex = firstSetCounts.count - 1
            
            Swift.print(lastIndex, productionCount)
            
            return firstSetCounts.count > productionCount
                && firstSetCounts[lastIndex] == firstSetCounts[lastIndex - productionCount]
            
        }
        
        var productionIndex = 0
        
        while !didReachFixedPoint {
            
            let production = productions[productionIndex]
            
            let lhs = production.lhs
            let firstRhs = production.rhs[0]
            
            if case .nonTerminal(let rhsNonTerminal) = firstRhs {
                let otherFirst = firstSets[rhsNonTerminal]!
                firstSets[lhs]?.formUnion(otherFirst)
            } else if case .terminal(let terminal) = firstRhs {
                firstSets[lhs]?.insert(terminal)
            }
            
            firstSetCounts.append(firstSetCount)
            productionIndex = (productionIndex + 1) % productionCount
            
        }
        
        Swift.print(firstSets)
        
    }
    
    private func calculateFollowSets() {
        
        
        
    }
    
    func print(with indentation: Int = 0) {
        
        let prefix = String(repeating: "\t", count: indentation)
        
        Swift.print("\n" + prefix + "Grammar {")
        
        productions.forEach {
            Swift.print(prefix + "\t\($0)")
        }
        
        Swift.print(prefix + "}\n")
        
    }
    
}
