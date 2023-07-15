
var p0 = Production(lhs: "S", rhs: [.nonTerminal("E")])
var p1 = Production(lhs: "E", rhs: [.nonTerminal("T"), .terminal("+"), .nonTerminal("E")])
var p2 = Production(lhs: "E", rhs: [.nonTerminal("T")])
var p3 = Production(lhs: "T", rhs: [.terminal("x")])

let grammar = Grammar(p0)

grammar.addProduction(p1)
grammar.addProduction(p2)
grammar.addProduction(p3)

let slr = SLRAutomaton(grammar)
slr.print()
