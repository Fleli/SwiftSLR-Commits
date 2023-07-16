extension SwiftLibrary {
    
    
    static var slrParserFunctions: String {
        
        return """
            
            func parse(_ tokens: [Token]) -> SLRNode? {
                
                self.index = 0
                self.input = tokens
                
                self.stack = []
                
                state_0()
                
                if stack.count != 1 {
                    print(stack)
                    return nil
                }
                
                return stack[0]
                
            }
            
            private func shift() {
                
                let token = input[index]
                let node = SLRNode(token)
                
                stack.append(node)
                
                index += 1
                
                print("After shift: \\(stack)")
                
            }
            
            private func reduce(_ numberOfStates: Int, to nonTerminal: String) {
                
                let rhsNodes = Array<SLRNode>(stack[stack.count - numberOfStates ..< stack.count])
                stack.removeLast(numberOfStates)
                let newNode = SLRNode(nonTerminal, rhsNodes)
                
                stack.append(newNode)
                
                print("After reduce: \\(stack)")
                
            }
            
            private func topOfStackIsToken(_ type: String) -> Bool {
                
                guard notExhausted else {
                    return false
                }
                
                return input[index].type == type
                
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
        
        """
        
    }
    
    
}
