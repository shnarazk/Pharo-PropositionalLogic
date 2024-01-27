"
Zero-suppressed Decision Diagram
"
Class {
	#name : 'ZDD',
	#superclass : 'DD',
	#category : 'PropositionalLogic',
	#package : 'PropositionalLogic'
}

{ #category : 'algorithm' }
ZDD >> reduce: aNode [

    | nodes subgraph vlist nextId |
    nodes := graph setIndex; allNodesSet.
    subgraph := (Array new: nodes size + 2 withAll: nil) at: 1 put: false; at: 2 put: true;
                        yourself.
    "Put each vertex u reachable from v on list vlist[u.index]"
    vlist := nodes inject: Dictionary new into: [ :dic :node |
                 dic at: node literal
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
