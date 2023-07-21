func interpretInput(_ input: String) throws -> [Production] {
    
    let tokens = try Lexer().lex(input)
    
    var index = 0
    var productions: [Production] = []
    
    while index < tokens.count {
        
        guard let production = parseProduction(&index, tokens) else {
            throw SLRError.failed
        }
        
        productions.append(production)
        
    }
    
    return productions
    
}

private func parseProduction(_ index: inout Int, _ tokens: [Token]) -> Production? {
    
    guard index <= tokens.count - 3 else {
        print("Index is \(index), tokens.count is \(tokens.count)")
        return nil
    }
    
    guard
        tokens[index].type == "nonTerminal",
        tokens[index + 1].type == "arrow"
    else {
        print("tokens[index] is \(tokens[index]). Next is \(tokens[index + 1])")
        tokens.forEach {print($0)}
        return nil
    }
    
    let lhs = tokens[index].content
    var rhs: [Symbol] = []
    var semantics: [Int] = []
    
    index += 2
    
    while (index < tokens.count) {
        
        print(index, tokens[index])
        
        let symbol: Symbol?
        let content = tokens[index].content
        
        switch tokens[index].type {
        case "terminal":
            let type = String(content.dropFirst())
            symbol = .terminal(type)
        case "nonTerminal":
            symbol = .nonTerminal(content)
        case "{":
            print(index, tokens, rhs)
            if let block = parseSemanticBlock(&index, tokens, rhs) {
                semantics = block
            } else {
                return nil
            }
            symbol = nil
        default:
            symbol = nil
        }
        
        if let symbol = symbol {
            
            rhs.append(symbol)
            index += 1
            
        } else {
            
            break
            
        }
        
    }
    
    while index < tokens.count, tokens[index].type == "newLine" {
        index += 1
    }
    
    return Production(lhs: lhs, rhs: rhs, semantics)
    
}

private func parseSemanticBlock(_ index: inout Int, _ tokens: [Token], _ rhs: [Symbol]) -> [Int]? {
    
    var references: [Int] = []
    
    // Current is '{'
    index += 1
    
    while index < tokens.count {
        
        let token = tokens[index]
        
        print(index, token)
        
        let referenceSubString: Substring?
        
        switch token.type {
        case "reference":
            index += 1
            referenceSubString = token.content[token.content.index(after: token.content.startIndex) ..< token.content.endIndex]
            print("reference")
        case "}":
            index += 1
            referenceSubString = nil
            print("}")
        default:
            return nil
        }
        
        if let string = referenceSubString, let reference = Int(string) {
            references.append(reference)
        } else {
            break
        }
        
    }
    
    return references
    
}
