extension SwiftLibrary {
    
    
    static func typesInFile() -> String {
        
        return """
        class SLRNode: CustomStringConvertible {
            
            let type: SLRNodeType
            let children: [SLRNode]
            
            init(_ token: Token) {
                self.type = .terminal(token)
                self.children = []
            }
            
            var description: String { type.description }
            
            init(_ name: String, _ children: [SLRNode]) {
                self.type = .nonTerminal(name)
                self.children = children
            }
            
            func description(_ indent: Int) -> String {
                
                let prefix = String(repeating: " ", count: indent)
                
                var description = prefix + type.description + "\\n"
                
                for child in children {
                    description += child.description(indent + 4)
                }
                
                return description
                
            }
            
        }
        
        enum SLRNodeType: CustomStringConvertible {
            
            case terminal(_ token: Token)
            case nonTerminal(_ name: String)
            
            var description: String {
                switch self {
                case .terminal(let token):      return token.type + "\t\tContent: \\(token.content)"
                case .nonTerminal(let name):    return name
                }
            }
            
        }
        
        struct Token {
            
            public var type: String
            public var content: String
            
            public init(_ type: String, _ content: String) {
                
                self.type = type
                self.content = content
                
            }
            
        }

        """
        
    }
    
    
}
