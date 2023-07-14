class Grammar {
    
    private var productions: [Production] = []
    
    func addProduction(_ production: inout Production) {
        
        production.grammar = self
        productions.append(production)
        
    }
    
    func productionsFor(_ nonTerminal: String) -> [Production] {
        
        return productions.filter { $0.lhs == nonTerminal }
        
    }
    
    init() {
        print("init grammar")
    }
    
    deinit {
        print("deinit grammar")
    }
    
}
