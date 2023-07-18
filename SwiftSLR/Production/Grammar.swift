class Grammar {
    
    var initialProduction: Production
    
    var productions: [Production] = []
    
    private var terminals: Set<String> = []
    
    var firstSets: [String : Set<String>] = [:]
    var followSets: [String : Set<String>] = [:]
    
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
    
    func calculateFirstSets() {
        
        firstSets = [:]
        
        
        
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
