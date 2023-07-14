#  Plan

## Overview

The generator takes a text file as input and produces an SLR parser as output. The SLR parser relies on the same Token type as SwiftLex.

## Sequence

`String`            ->          `[Token]`                               lexical analysis        (Using SwiftLex)

    Tokens have information about type and content, to separate syntactic operators from actual content
    
`[Token]`           ->          `[Production]`                          input parsing

    Productions include information about left- and right hand side of a grammatical production. Each production can also
    recursively find a closure: A set of states that makes up an SLR state (much the same way NFAs are grouped into DFAs
    by finding closures).
    
`[Production]`      ->          `SLRAutomaton`                          finding closures & transitions

    

## Product

The actual parser generated will first produce generic SLRNode nodes (with a type to indicate the meaning of each node).

    class SLRNode {
        
        let type: String
        
        var children: [SLRNode] = []
        
        init(type: String) {
            self.type = type
        }
        
    }

Then the SLRNode tree will be converted to a tree of specific nodes as described by the user, for instance Expression, Declaration, etc.
