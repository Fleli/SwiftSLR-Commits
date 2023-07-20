extension SwiftLibrary {
    
    
    static func typesInFile(_ includingToken: Bool) -> String {
        
        let tail = includingToken ? """
        
        struct Token: CustomStringConvertible {
            
            public var type: String
            public var content: String
            
            public var description: String { type }
            
            public init(_ type: String, _ content: String) {
                
                self.type = type
                self.content = content
                
            }
            
        }
        """ : ""
        
        return """
        enum ParseError: Error {
            case unexpected(_ nonTerminal: String, _ content: String, _ expected: String)
            case abruptEnd(_ nonTerminal: String, _ expected: String)
        }
        
        protocol SLRNode: CustomStringConvertible {}
        
        class SLRNonTerminal: SLRNode, CustomStringConvertible {
            
            let type: String
            
            var description: String { type }
            
            init(_ type: String) {
                self.type = type
            }
            
        }
        
        extension Token: SLRNode {}
        \(tail)
        """
        
    }
    
    
}
