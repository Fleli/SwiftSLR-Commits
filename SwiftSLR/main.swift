

let grammar = Grammar()

var p1 = Production(lhs: "A", rhs: [.nonTerminal("B"), .terminal("c")])
var p2 = Production(lhs: "B", rhs: [.nonTerminal("D")])
var p3 = Production(lhs: "M", rhs: [.terminal("k")])

grammar.addProduction(&p1); print("Finished 8")
grammar.addProduction(&p2); print("Finished 9")
grammar.addProduction(&p3)

let closure = p1.closure

print(closure)
