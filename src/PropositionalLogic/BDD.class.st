"
Binary Decision Diagram

Bryant, Randal E., _Graph-Based Algorithms for Boolean Function Manipulation_ [PDF](https://apps.dtic.mil/sti/pdfs/ADA470446.pdf). IEEE Transactions on Computers. C-35 (8): 677–691. CiteSeerX 10.1.1.476.2952. doi:10.1109/TC.1986.1676819. S2CID 10385726.  August 1986.

- https://apps.dtic.mil/sti/pdfs/ADA470446.pdf

## reduce

```language=text
	fn reduce(v: vertex) -> vertex {
		let mut subgraph: array<vertex>[1..|G|];
		let mut vlist: array<list>[1..n+1];
		put each vertex u on list vlist[u.index];
		let mut nextid = 0;
		for i in (1..=n+1).rev() {
			let mut Q = empty set;
			for each in vllist[i] {
				if u.index == n + 1 {
					add <key, u> to Q where key = (u.value); // terminal vertex
				} else if u.low.id == u.high.id {
					u.id = u.low.id // redundant vertex
				} else {
					add <key, u> to Q where key = (u.low.id, u.high.id);
				}
			}
			Q.sort(); // sort elements of Q by keys;
			let mut oldkey = (-1, -1);     // unmatchable key
			for <key, u> in Q removed in order do {
				if key == oldkey {
					u.id = nextid;     // matches existing vertex
				} else {              // unique vertex
					nextid = nextid + 1;
					u.id = nextid;
					subgraph[nextidd] = u;
					u.low = subgraph[u.low.id];
					u.high = subgraph[u.high.id];
					oldkey = key;
				}
			}
		}
		subgraph[v.id]
	}
```

## apply
```language=text
	fn apply(v1: vertex, v2: vertex; op: Operator) -> vertex {
	  // Recursive routine to implement Apply
	  fn apply_step(mut T: Array<vertex>, v1: vertex; v2: vertex, op: Operator) -> vertex {
	    let mut u = T[v1.id, v2.id];
	    if u != null { return u; }    // have already evaluated
	    u = vertex::new();
	    u.mark = false;
	    T[v1.id, v2.id] = v1.value op v2.value;
	    if u.value != X {
	      // create terminal vervex
	      u.index = n + 1;
	      u.low = null; u.high = null;
	    } else {
	      u.inddex = v1.index.min(v2.index);
	      if v1.index == u.index { vlow1 = v1.low; vhigh1 = v1.hight; } else { vlow1 = v1; vhigh1 = v1; }
	      if v2.index == u.index { vlow2 = v2.low; vhigh2 = v2.hight; } else { vlow2 = v2; vhigh2 = v2; }
	      u.low = apply_step(T, vlow1, vlow2, op);
	      u.high = apply_step(T, vhigh1, vhigh2, op);
	    }
	    u
	  }
	  let mut T: Array<vertex>[1..|G1|, 1..|G2|];
	  initialize all elements of T to null;
	  reduce(apply_step(T, v1, v2, op))
	}
```
"
Class {
	#name : 'BDD',
	#superclass : 'DD',
	#category : 'PropositionalLogic-DecisionDiagram',
	#package : 'PropositionalLogic',
	#tag : 'DecisionDiagram'
}

{ #category : 'algorithm - private' }
BDD >> apply: operator on: v1 and: v2 using: aTable [
    "recursive routine to implement apply:unit:with:. Both of v1 and v2 are non-terminal vertexes."

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

    | controlling hashKey value1 value2 value u |
    controlling := aTable at: 0.
    hashKey := (v1 isLiteral ifTrue: [ v1 ifFalse: [ 1 ] ifTrue: [ 2 ] ] ifFalse: [ v1 index ])
               @ (v2 isLiteral ifTrue: [ v2 ifFalse: [ 1 ] ifTrue: [ 2 ] ] ifFalse: [ v2 index ]).
    aTable at: hashKey ifPresent: [ :node | node ifNotNil: [ ^ node "have already evaluated" ] ].
    value1 := aTable at: v1 ifAbsent: [ nil ].
    value2 := aTable at: v2 ifAbsent: [ nil ].
    "u.value := v1.value <op> v2.value"
    value := (value1 = controlling or: [ value2 = controlling ]) ifTrue: [ controlling ]
                 ifFalse: [
                 value1 ifNotNil: [ value2 ifNotNil: [ operator value: value1 value: value2 ] ] ].
    u := value ifNil: [
             | v1Literal v2Literal vlow1 vlow2 vhigh1 vhigh2 w |
             "create a nonterminal vertex and evaluate further down"
             w := DDNode new.
             aTable at: w put: value.
             v1Literal := v1 isLiteral ifTrue: [ v1 ] ifFalse: [ v1 literal ].
             v2Literal := v2 isLiteral ifTrue: [ v2 ] ifFalse: [ v2 literal ].
             w literal: (v1 isLiteral ifTrue: [
                      v2 isLiteral ifTrue: [ operator value: v1 value: v2 ] ifFalse: [ v2Literal ] ]
                      ifFalse: [
                      v2 isLiteral ifTrue: [ v1Literal ] ifFalse: [ v1 literal min: v2 literal ] ]).
             vlow1 := v1Literal = w literal ifTrue: [ v1 low ] ifFalse: [ v1 ].
             vlow2 := v2Literal = w literal ifTrue: [ v2 low ] ifFalse: [ v2 ].
             vhigh1 := v1Literal = w literal ifTrue: [ v1 high ] ifFalse: [ v1 ].
             vhigh2 := v2Literal = w literal ifTrue: [ v2 high ] ifFalse: [ v2 ].
             w low: (self apply: operator on: vlow1 and: vlow2 using: aTable).
             w high: (self apply: operator on: vhigh1 and: vhigh2 using: aTable).
             w ].
    aTable at: hashKey put: u.
    ^ u
]

{ #category : 'algorithm' }
BDD >> compose: x1 and: x2 [

    self notYetImplemented
]

{ #category : 'algorithm - private' }
BDD >> reduce: aNode [
    "This is an abnormal implementation of BDD>>reduce since index order is reveresed."

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
                 u low == u high ifTrue: [ u index: u lowIndex ]
                     ifFalse: [ c add: u lowIndex @ u highIndex -> u ].
                 c ].
        oldKey := nil. "unmatchable key"
        q sorted do: [ :tmp |
            | key u |
            key := tmp key.
            u := tmp value.
            self assert: u low ~= u high description: 'this should be deleted'.
            key = oldKey ifTrue: [ u index: nextId "matches existing vervex" ]
                ifFalse: [ "unique vertex"
                    nextId := nextId + 1.
                    u index: nextId; low: (subgraph at: u lowIndex); high:
                            (subgraph at: u highIndex).
                    subgraph at: nextId put: u.
                    oldKey := key ] ] ].
    ^ subgraph at: aNode index
]

{ #category : 'algorithm' }
BDD >> restrict: varIndex [

	self notYetImplemented
]

{ #category : 'evaluating' }
BDD >> satisfyAll [

	self notYetImplemented
]

{ #category : 'evaluating' }
BDD >> satisfyCount [

	self notYetImplemented
]

{ #category : 'evaluating' }
BDD >> satisfyOne [

	self notYetImplemented
]
