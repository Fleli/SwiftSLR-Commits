extension SwiftLibrary {
    
    
    static var slrParserFunctions: String {
        
        return """
            
            func parse(_ tokens: [Token]) throws -> SLRNode? {
                
                self.index = 0
                self.input = tokens
                
                self.accepted = false
                
                self.stack = []
                self.states = [state_0]
                
                repeat {
                    
                    try states[states.count - 1]()
                    
                } while !accepted
                
                if stack.count != 1 {
                    print(stack)
                    return nil
                }
                
                return stack[0]
                
            }
            
            private func shift() {
                
                let token = input[index]
                stack.append(token)
                index += 1
                
            }
            
            private func reduce(_ numberOfStates: Int, to newNode: some SLRNode) {
                
                stack.removeLast(numberOfStates)
                states.removeLast(numberOfStates)
                
                stack.append(newNode)
                
            }
            
            private func topOfStackIsToken(_ type: String) -> Bool {
                return topOfStackIsAmong([type])
            }
            
            private func topOfStackIsAmong(_ terminals: Set<String?>) -> Bool {
                
                guard notExhausted else {
                    return terminals.contains(nil)
                }
                
                return terminals.contains(input[index].type)
                
            }
            
            private func topOfStackIsNonTerminal(_ type: String) -> Bool {
                
                guard stack.count > 0 else {
                    return false
                }
                
                guard let nonTerminal = stack[stack.count - 1] as? SLRNonTerminal else {
                    return false
                }
                
                return type == nonTerminal.type
                
            }
            
            private func pushState(_ newState: @escaping () throws -> ()) {
                states.append(newState)
            }
        
        """
        
    }
    
    
}
