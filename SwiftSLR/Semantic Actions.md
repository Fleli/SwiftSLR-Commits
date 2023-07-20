# Semantic Actions

Instead of just generating a tree of SLRNode objects (each with a specified type and some number of children), the
user should be able to inject code into each production so that the tree can be transformed into a user-defined type
instead. For instance, the several `Statements -> Statements Statement` productions could use such actions to
automatically flatten the (skewed) tree into `[Statement]`, representing the same thing but being much easier to work
with and reason about.

To allow for such actions, `SLRNode` should be a protocol instead of a class. Each (user-defined) class must conform
to this protocol in order to fit into the stack that holds the shifted terminals and generated non-terminals.

Run-time casting should be used whenever a new node is created using other nodes, since the general `SLRNode` won't fit
into the stricter types required for initializing the left-hand side of a production.


