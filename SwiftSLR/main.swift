

var p1 = Production(lhs: "D", rhs: [.nonTerminal("E"), .nonTerminal("F")])
var p2 = Production(lhs: "E", rhs: [.terminal("y")])
var p3 = Production(lhs: "E", rhs: [.nonTerminal("F")])
var p4 = Production(lhs: "F", rhs: [.terminal("x")])

let grammar = Grammar(p1)

grammar.addProduction(p2)
grammar.addProduction(p3)
grammar.addProduction(p4)

p1.closure.forEach { print($0) }

let slr = SLRAutomaton(grammar)
slr.print()
