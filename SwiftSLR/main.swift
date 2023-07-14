

var p1 = Production(lhs: "A", rhs: [.nonTerminal("B"), .terminal("c")])
var p2 = Production(lhs: "B", rhs: [.nonTerminal("D")])
var p3 = Production(lhs: "M", rhs: [.terminal("k")])

let grammar = Grammar(p1)

grammar.addProduction(p1)
grammar.addProduction(p2)
grammar.addProduction(p3)

let closure = p1.closure

print(closure)
