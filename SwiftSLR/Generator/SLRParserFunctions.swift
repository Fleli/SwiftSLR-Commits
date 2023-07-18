extension SwiftLibrary {
    
    
    static var slrParserFunctions: String {
        
        return """
            
            func parse(_ tokens: [Token]) -> SLRNode? {
                
                self.index = 0
                self.input = tokens
                
                self.stack = []
                self.states = [state_0]
                
                repeat {
                    
                    let current = states[states.count - 1]
                    current()
                    
                } while (stack.count == 1) || (stack[1].type != .nonTerminal("Program"))
                
                if stack.count != 2 {
                    print(stack)
                    return nil
                }
                
                return stack[1]
                
            }
            
            private func shift() {
                
                let token = input[index]
                let node = SLRNode(token)
                
                stack.append(node)
                
                index += 1
                
            }
            
            private func reduce(_ numberOfStates: Int, to nonTerminal: String) {
                
                let rhsNodes = Array<SLRNode>(stack[stack.count - numberOfStates ..< stack.count])
                let newNode = SLRNode(nonTerminal, rhsNodes)
                
                stack.removeLast(numberOfStates)
                states.removeLast(numberOfStates)
                
                stack.append(newNode)
                
            }
            
            private func topOfStackIsToken(_ type: String) -> Bool {
                return topOfStackIsAmong([type])
            }
            
            private func topOfStackIsAmong(_ terminals: Set<String>) -> Bool {
                
                guard notExhausted else {
                    return false
                }
                
                return terminals.contains(input[index].type)
            
            }
            
            private func topOfStackIsNonTerminal(_ nonTerminal: String) -> Bool {
                
                guard stack.count > 0 else {
                    return false
                }
                
                guard case .nonTerminal(let name) = stack[stack.count - 1].type else {
                    return false
                }
                
                return name == nonTerminal
                
            }
            
            private func pushState(_ newState: @escaping () -> ()) {
                states.append(newState)
            }
        
        """
        
    }
    
    
}
