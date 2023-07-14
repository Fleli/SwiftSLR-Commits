class Grammar {
    
    var initialProduction: Production
    
    private var productions: [Production] = []
    
    func addProduction(_ production: Production) {
        
        production.grammar = self
        productions.append(production)
        
    }
    
    func productionsFor(_ nonTerminal: String) -> [Production] {
        
        return productions.filter { $0.lhs == nonTerminal }
        
    }
    
    init(_ initialProduction: Production) {
        
        self.initialProduction = initialProduction
        
        addProduction(self.initialProduction)
        
    }
    
}
