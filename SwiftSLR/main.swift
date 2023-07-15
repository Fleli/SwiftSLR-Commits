
var p0 = Production(lhs: "S'", rhs: [.nonTerminal("S")])
var p1 = Production(lhs: "S", rhs: [.terminal("("), .nonTerminal("L"), .terminal(")")])
var p2 = Production(lhs: "S", rhs: [.terminal("x")])
var p3 = Production(lhs: "L", rhs: [.nonTerminal("S")])
var p4 = Production(lhs: "L", rhs: [.nonTerminal("L"), .terminal(","), .nonTerminal("S")])

let grammar = Grammar(p0)

grammar.addProduction(p1)
grammar.addProduction(p2)
grammar.addProduction(p3)
grammar.addProduction(p4)

let slr = SLRAutomaton(grammar)
slr.print()
