extension SwiftLibrary {
    
    
    static func slrClass(_ slrStateFunctions: String) -> String {
        
        return """
        
        class SLRParser {
        \(slrParserFields)
        \(slrParserFunctions)
        \(slrStateFunctions)
        }
        """
        
    }
    
    
}
