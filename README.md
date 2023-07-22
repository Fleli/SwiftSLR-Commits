# About SwiftSLR

SwiftSLR is a parser generator written in Swift, producing Simple LR (SLR) parsers expressed in Swift.
The generator takes in a string describing the desired grammar (which must be SLR parsable). It writes
an SLR parser accepting languages fitting that grammar to a file, and prints (to console) an SLR automaton
that describes the operation of the parser.

## Input

Use the multi-line string `input` in `main.swift` to define your grammar. Each line should contain at most
one production. A production has a non-terminal (regex `[A-Z][a-zA-Z]*`) on the left. That non-terminal is
followed by an arrow (`->`) and one or more symbols on the RHS of the production. Then some number of
references ($0, $1, ...) is expected to inform the parser how non-terminals are related.

Each symbol is a non-terminal (as described) or terminal (prefixed with `#`). Terminals will match whenever 
a token's type is equal to the specified terminal type. 

Note: The grammar's first production's LHS non-terminal should be unique so that it is the only accepting
production. The LHS symbol will be the only symbol on the stack when parsing is (successfully) completed.

## Output

The parser generator will produce an SLR parser as its output. The SLR parser is found in an `SLRParser`
class. To use the parser, initialize such an object (`let parser = SLRParser()`) and call its `parse`
method. It expects an array of `Token` objects and produces some object conforming to the SLRNode protocol.
These types must (for now) be defined by the user.

## Integration with SwiftLex

SwiftLex (https://github.com/Fleli/SwiftLex) is a lexer generator written in a similar way. SwiftSLR is
designed to work well with SwiftLex. If a SwiftLex lexer is present, it will include a `Token` type. The
user of SwiftSLR therefore has the option not to produce a `Token` type in the generated parser file (to
avoid multiple definitions). This is done by settings `includingToken` to `false` when generating the parser.

## Inner workings

SwiftSLR is divided into 5 steps:
 Step   | Input             | Output            | Description 
--------|-------------------|-------------------|------------
1       | `String`          | `[Production]`    | Parse the user's input to see each production
2       | `[Production]`    | `Grammar`         | Create a grammar from the array of productions
3       |                   |           	    | Calculate FIRST and FOLLOW sets for each non-terminal
4       | `Grammar`         | `SLRAutomaton`    | Use the grammar to create an SLR automaton
5       | `SLRAutomaton`    | `String`          | Generate code from the automaton

The `String` produced in step 5 is written to a file specified by the user.

