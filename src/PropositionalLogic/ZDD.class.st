"
Zero-suppressed Decision Diagram
"
Class {
	#name : 'ZDD',
	#superclass : 'DD',
	#category : 'PropositionalLogic-DecisionDiagram',
	#package : 'PropositionalLogic',
	#tag : 'DecisionDiagram'
}

{ #category : 'algorithm - private' }
ZDD >> apply: operator on: v1 and: v2 using: aTable [
    "recursive routine to implement apply:base:with::. Both of v1 and v2 are non-terminal vertexes."

    "Second, suppose the algorithm is applied to two vertices where one, say v1, is a terminal vertex,
    and for this particular operator, value(v1) is a ""controlling"" value, i.e. either
    value(v1) <op> a = 1 for all a, or value(v1) <op> a = 0 for all a. For example, 1 is a controlling
    value for either argument of OR, while 0 is a controlling value for either argument of AND. In this
    case, there is no need to evaluate further. We simply create a terminal vertex having the
    appropriate value."

    "To detect whether one of the two vertices contains a controlling value for the operator, we evaluate
    the expression v1.value <op> v2.value using a three-valued algebra where X (the value at any
    nonterminal vertex) represents ""don’t care"". That is, if b <op> 1 = b <op> 0 = a, then b <op> X =
    a, otherwise b <op> X = X."

    self notYetImplemented
]

{ #category : 'algorithm - private' }
ZDD >> reduce: aNode [

    | nodes subgraph vlist nextId |
    nodes := graph setIndex; allNodesSet.
    subgraph := (Array new: nodes size + 2 withAll: nil) at: 1 put: false; at: 2 put: true;
                        yourself.
    "Put each vertex u reachable from v on list vlist[u.index]"
    vlist := nodes inject: Dictionary new into: [ :dic :node |
                 dic at: node varIndex
                     ifPresent: [ :set | set add: node ]
                     ifAbsentPut: [ OrderedCollection new add: node; yourself ]; yourself ].
    nextId := 2.
    vlist keys sorted reversed do: [ :literal |
        | q oldKey |
        q := (vlist at: literal) inject: OrderedCollection new into: [ :c :u |
                 u high = false ifTrue: [ "This is ruduction rule of ZDD" u index: u lowIndex ]
                     ifFalse: [ c add: u lowIndex @ u highIndex -> u ].
                 c ].
        oldKey := nil. "unmatchable key"
        q sorted do: [ :tmp |
            | key u |
            key := tmp key.
            u := tmp value.
            key = oldKey ifTrue: [ u index: nextId "matches existing vervex" ]
                ifFalse: [ "unique vertex"
                    nextId := nextId + 1.
                    u index: nextId; low: (subgraph at: u lowIndex); high:
                            (subgraph at: u highIndex).
                    subgraph at: nextId put: u.
                    oldKey := key ] ] ].
    ^ subgraph at: aNode index
]
