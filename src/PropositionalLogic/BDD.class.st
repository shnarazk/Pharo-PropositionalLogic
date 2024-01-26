"
Binary Decision Diagram

Bryant, Randal E., _Graph-Based Algorithms for Boolean Function Manipulation_ [PDF](https://apps.dtic.mil/sti/pdfs/ADA470446.pdf). IEEE Transactions on Computers. C-35 (8): 677–691. CiteSeerX 10.1.1.476.2952. doi:10.1109/TC.1986.1676819. S2CID 10385726.  August 1986.

- https://apps.dtic.mil/sti/pdfs/ADA470446.pdf

## reduce

```rust
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
			for <key, u> in Q removed in order do {  // while let Some((key, u)) = Q.pop() {  }
				if key == oldkey {
					u.id = nextid;     // matches existing vertex
				} else {             // unique vertex
					nextid = nextid + 1; u.id = nextid; subgraph[nextidd] = u; u.low = subgraph[u.low.id]; u.high = subgraph[u.high.id]; oldkey = key;
				}
			}
		}
		subgraph[v.id]
	}
```

## apply
```
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
	      if v1.index == u.index { vlow1 = v1.low; vhigh1 = v1.hight;  } else {   vlow1 = v1; vhigh1 = v1; }
	      if v2.index == u.index {  vlow2 = v2.low; vhigh2 = v2.hight;  } else {   vlow2 = v2; vhigh2 = v2; }
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
	#category : 'PropositionalLogic',
	#package : 'PropositionalLogic'
}

{ #category : 'algorithm' }
BDD >> and: other [

	^ self apply: [ :a :b | a & b ] with: other withControllingValue: false
]

{ #category : 'algorithm - private' }
BDD >> apply: aBlock on: v1 and: v2 withTable: aTable [
    "recursive routine to implement apply:with:withControllingValue:"

    | v1index v2index u value1 value2 value |
    v1index := v1 isLiteral ifTrue: [ v1 ifFalse: [ 1 ] ifTrue: [ 3 ] ] ifFalse: [ v1 index ].
    v2index := v2 isLiteral ifTrue: [ v2 ifFalse: [ 1 ] ifTrue: [ 2 ] ] ifFalse: [ v2 index ].
    u := aTable at: v1index @ v2index ifAbsent: [ nil ].
    u ifNotNil: [ ^ u "have already evaluated" ].
    u := DDNode new.
    aTable at: v1index @ v2index put: u. "add vertex to table"
    "u.value := v1.value <op> v2.value"
    value1 := aTable at: v1.
    value2 := aTable at: v2.
    value := value1
                 ifNil: [
                     value2 ifNil: [ nil ] ifNotNil: [
                         | a b |
                         a := aBlock value: false value: value2.
                         b := aBlock value: true value: value2.
                         a = b ifTrue: [ a ] ifFalse: [ nil ] ] ]
                 ifNotNil: [
                     value2
                         ifNil: [
                             | a b |
                             a := aBlock value: value1 value: false.
                             b := aBlock value: value1 value: true.
                             a = b ifTrue: [ a ] ifFalse: [ nil ] ]
                         ifNotNil: [ aBlock value: value1 value: value2 ] ].
    aTable at: u put: value.
    value ifNotNil: [ "create terminal vertex" u index: (value ifFalse: [ 1 ] ifTrue: [ 2 ]) ]
        ifNil: [
            | vlow1 vlow2 vhigh1 vhigh2 |
            "create nonterminal and evaluate further down"
            u index: (v1 index min: v2 index).
            v1 index = u index
                ifTrue: [
                    vlow1 := v1 low.
                    vhigh1 := v1 high ]
                ifFalse: [
                    vlow1 := v1.
                    vhigh1 := v1 ].
            v2 index = u index
                ifTrue: [
                    vlow2 := v2 low.
                    vhigh2 := v2 high ]
                ifFalse: [
                    vlow2 := v2.
                    vhigh2 := v2 ].
            u low: (self apply: aBlock on: vlow1 and: vlow2 withTable: aTable).
            u high: (self apply: aBlock on: vlow1 and: vlow2 withTable: aTable) ].
    ^ u

    "
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
    if v1.index == u.index { vlow1 = v1.low; vhigh1 = v1.hight;  } else {   vlow1 = v1; vhigh1 = v1; }
    if v2.index == u.index {  vlow2 = v2.low; vhigh2 = v2.hight;  } else {   vlow2 = v2; vhigh2 = v2; }
    u.low = apply_step(T, vlow1, vlow2, op);
    u.high = apply_step(T, vhigh1, vhigh2, op);
    }
    u
    }
    let mut T: Array<vertex>[1..|G1|, 1..|G2|];
    initialize all elements of T to null;
    reduce(apply_step(T, v1, v2, op))
    }
    "
]

{ #category : 'algorithm' }
BDD >> apply: anOperator with: other withControllingValue: aBool [
    "corntrollingValue should be embedded to aTable at 1 and 2"

    | aDict otherGraph |
    aDict := Dictionary new at: false put: aBool; at: true put: aBool; yourself.
    otherGraph := other graph reindexedClone: graph allNodesSet size + 1.
    "set all v values here"
    graph := self apply: anOperator on: graph and: otherGraph withTable: aDict.
    ^ self reduce
    "
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
    if v1.index == u.index { vlow1 = v1.low; vhigh1 = v1.hight;  } else {   vlow1 = v1; vhigh1 = v1; }
    if v2.index == u.index {  vlow2 = v2.low; vhigh2 = v2.hight;  } else {   vlow2 = v2; vhigh2 = v2; }
    u.low = apply_step(T, vlow1, vlow2, op);
    u.high = apply_step(T, vhigh1, vhigh2, op);
    }
    u
    }
    let mut T: Array<vertex>[1..|G1|, 1..|G2|];
    initialize all elements of T to null;
    reduce(apply_step(T, v1, v2, op))
    }
    "
]

{ #category : 'algorithm' }
BDD >> compose:  x1 and: x2 [

	self notYetImplemented
]

{ #category : 'algorithm' }
BDD >> or: other [

	^ self apply: [ :a :b | a | b ] with: other withControllingValue: true
]

{ #category : 'algorithm' }
BDD >> reduce [

	self reduce: graph
]

{ #category : 'algorithm - private' }
BDD >> reduce: aNode [

	| nodes subgraph vlist nextId |
	nodes := graph setIndex; allNodesSet.
	subgraph := (Array new: nodes size + 2 withAll: nil) at: 1 put: false; at: 2 put: true; yourself.
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
			key = oldKey ifTrue: [ u index: nextId "matches existing vervex" ] ifFalse: [ "unique vertex"
				nextId := nextId + 1.
				u index: nextId; low: (subgraph at: u lowIndex); high: (subgraph at: u highIndex).
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

{ #category : 'as yet unclassified' }
BDD >> storeValuationsOf: aGraph to: aTable [

    <todo: 'FIXME'>
    | nodes operator val |
    operator := aTable at: 0.
    val := operator value: false value: false.
    aTable at: 1 put: (val = (operator value: false value: true) ifTrue: [ val ] ifFalse: [ nil ]).
    val := operator value: true value: false.
    aTable at: 2 put: (val = (operator value: true value: true) ifTrue: [ val ] ifFalse: [ nil ]).
    nodes := aGraph allNodesSet.
    nodes := (nodes collect: [ :node | node index -> node ]) asOrderedCollection sorted.
    "Now evaluate each clause in bottom up way."
    nodes do: [ :association |
        | index node |
        index := association key.
        node := association value ]
]
