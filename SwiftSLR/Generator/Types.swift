extension SwiftLibrary {
    
    
    static func typesInFile(_ includingToken: Bool) -> String {
        
        let tail = includingToken ? """
        
        struct Token {
            
            public var type: String
            public var content: String
            
            public init(_ type: String, _ content: String) {
                
                self.type = type
                self.content = content
                
            }
            
        }
        """ : ""
        
        return """
        enum ParseError: Error {
            case unexpected(_ content: String)
            case abruptEnd(_ production: String)
        }
        
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
                
                let prefix = String(repeating: "|   ", count: indent / 4)
                
                var description = prefix + type.description + "\\n"
                
                for child in children {
                    description += child.description(indent + 4)
                }
                
                return description
                
            }
            
        }
        
        enum SLRNodeType: CustomStringConvertible, Equatable {
            
            case terminal(_ token: Token)
            case nonTerminal(_ name: String)
            
            var description: String {
                switch self {
                case .terminal(let token):      return token.type
                case .nonTerminal(let name):    return name
                }
            }
            
            static func == (lhs: SLRNodeType, rhs: SLRNodeType) -> Bool {
                
                switch (lhs, rhs) {
                case (.terminal(let t1), .terminal(let t2)):
                    return t1.type == t2.type
                case (.nonTerminal(let n1), .nonTerminal(let n2)):
                    return n1 == n2
                default:
                    break
                }
                
                return false
                
            }
            
        }
        \(tail)
        """
        
    }
    
    
}
