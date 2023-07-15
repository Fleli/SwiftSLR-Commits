enum SLRAction {
    
    case shift(_ newState: Int)
    case goto(_ newState: Int)
    case accept
    
}
