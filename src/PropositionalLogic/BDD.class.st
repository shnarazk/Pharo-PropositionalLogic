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
BDD >> apply: operator on: v1 and: v2 withMapping: aMapping withValue: values [
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
    controlling := values at: 0.
    hashKey := (aMapping at: v1) @ (aMapping at: v2).
    aMapping at: hashKey ifPresent: [ :node | node ifNotNil: [ ^ node "have already evaluated" ] ].
    value1 := values at: v1 ifAbsent: [ nil ].
    value2 := values at: v2 ifAbsent: [ nil ].
    "u.value := v1.value <op> v2.value"
    value := (value1 = controlling or: [ value2 = controlling ]) ifTrue: [ controlling ]
                 ifFalse: [
                 value1 ifNotNil: [ value2 ifNotNil: [ operator value: value1 value: value2 ] ] ].
    u := value ifNil: [
             | v1Literal v2Literal vlow1 vlow2 vhigh1 vhigh2 w |
             "create a nonterminal vertex and evaluate further down"
             w := DDNode new.
             values at: w put: value.
             v1Literal := v1 isLiteral ifTrue: [ v1 ] ifFalse: [ v1 varIndex ].
             v2Literal := v2 isLiteral ifTrue: [ v2 ] ifFalse: [ v2 varIndex ].
             w varIndex: (v1 isLiteral ifTrue: [
                      v2 isLiteral ifTrue: [ operator value: v1 value: v2 ] ifFalse: [ v2Literal ] ]
                      ifFalse: [
                      v2 isLiteral ifTrue: [ v1Literal ] ifFalse: [ v1 varIndex min: v2 varIndex ] ]).
             vlow1 := v1Literal = w varIndex ifTrue: [ v1 low ] ifFalse: [ v1 ].
             vlow2 := v2Literal = w varIndex ifTrue: [ v2 low ] ifFalse: [ v2 ].
             vhigh1 := v1Literal = w varIndex ifTrue: [ v1 high ] ifFalse: [ v1 ].
             vhigh2 := v2Literal = w varIndex ifTrue: [ v2 high ] ifFalse: [ v2 ].
             w low: (self apply: operator
                      on: vlow1
                      and: vlow2
                      withMapping: aMapping
                      withValue: values).
             w high: (self apply: operator
                      on: vhigh1
                      and: vhigh2
                      withMapping: aMapping
                      withValue: values).
             w ].
    aMapping at: hashKey put: u.
    ^ u
]

{ #category : 'algorithm - private' }
BDD >> composeGraphLow: nodeLow high: nodeHigh and: otherNode withMapping: aMapping withValue: values [
    "Recursive routine to implement BDD>>compose:and:at:"

    | vlow1 vhigh1 value nodes hashKey |
    vlow1 := nodeLow.
    vhigh1 := nodeHigh.
    nodes := OrderedCollection new add: vlow1; add: vhigh1; add: otherNode; yourself.
    vlow1 isLiteral ifFalse: [ vlow1 varIndex = (values at: 0) ifTrue: [ vlow1 := vlow1 low ] ].
    vhigh1 isLiteral ifFalse: [ vhigh1 varIndex = (values at: 0) ifTrue: [ vhigh1 := vhigh1 high ] ].
    "Apply operation IfThenElse"
    hashKey := nodes collect: [ :each | aMapping at: each ].
    aMapping at: hashKey ifPresent: [ :evaluated | "have already evaluaeted" ^ evaluated ].
    value := values at: otherNode ifPresent: [ :b2 |
                 values at: vlow1
                     ifPresent: [ :bl |
                     values at: vhigh1 ifPresent: [ :bh | b2 not & bl | (b2 & bh) ] ] ].
    ^ value
          ifNotNil: [
              aMapping at: hashKey put: value. "add vertex to table"
              value ]
          ifNil: [ "create nonterminal and evaluate further down"
              | u varIndex vll1 vhl1 vlh1 vhh1 vl2 vh2 |
              u := DDNode new.
              aMapping at: hashKey put: u. "add vertex to table"
              aMapping at: u put: value.
              varIndex := nodes inject: 0 into: [ :vi :node |
                              node isLiteral ifTrue: [ vi ]
                                  ifFalse: [
                                  vi = 0 ifTrue: [ node varIndex ]
                                      ifFalse: [ node varIndex min: vi ] ] ].
              self assert: varIndex ~= 0 description: 'invaild varIndex for new node'.
              u varIndex: varIndex.
              vll1 := vlow1 isLiteral ifTrue: [ vlow1 ]
                          ifFalse: [
                          vlow1 varIndex = varIndex ifTrue: [ vlow1 low ] ifFalse: [ vlow1 ] ].
              vlh1 := vlow1 isLiteral ifTrue: [ vlow1 ]
                          ifFalse: [
                          vlow1 varIndex = varIndex ifTrue: [ vlow1 high ] ifFalse: [ vlow1 ] ].
              vhl1 := vhigh1 isLiteral ifTrue: [ vhigh1 ]
                          ifFalse: [
                          vhigh1 varIndex = varIndex ifTrue: [ vhigh1 low ] ifFalse: [ vhigh1 ] ].
              vhh1 := vhigh1 isLiteral ifTrue: [ vhigh1 ]
                          ifFalse: [
                          vhigh1 varIndex = varIndex ifTrue: [ vhigh1 high ] ifFalse: [ vhigh1 ] ].
              vl2 := otherNode isLiteral ifTrue: [ otherNode ]
                         ifFalse: [
                         otherNode varIndex = varIndex ifTrue: [ otherNode low ]
                             ifFalse: [ otherNode ] ].
              vh2 := otherNode isLiteral ifTrue: [ otherNode ]
                         ifFalse: [
                         otherNode varIndex = varIndex ifTrue: [ otherNode high ]
                             ifFalse: [ otherNode ] ].
              u low: (self composeGraphLow: vll1
                       high: vhl1
                       and: vl2
                       withMapping: aMapping
                       withValue: values).
              u high: (self composeGraphLow: vlh1
                       high: vhh1
                       and: vh2
                       withMapping: aMapping
                       withValue: values).
              u ]
]

{ #category : 'algorithm - private' }
BDD >> reduce: aNode [
    "This is an abnormal implementation of BDD>>reduce since index order is reveresed."

    | nodes subgraph vlist nextId index |
    nodes := graph allNodesSet. "setIndex;"
    "mapping from node to index: integer"
    index := IdentityDictionary newFrom:
                 (nodes asArray withIndexCollect: [ :node :i | node -> (i + 2) ]).
    index at: false put: 1; at: true put: 2.
    "mapping from index: integer to (non)terminal node"
    subgraph := IdentityDictionary new at: 1 put: false; at: 2 put: true; yourself.
    "Put each vertex u reachable from v on list vlist[u.index]"
    vlist := nodes inject: Dictionary new into: [ :dic :node |
                 dic at: node varIndex
                     ifPresent: [ :set | set add: node ]
                     ifAbsentPut: [ Set new add: node; yourself ]; yourself ].
    nextId := 2.
    vlist keys sorted reversed do: [ :varIndex |
        | q oldKey |
        q := (vlist at: varIndex) inject: OrderedCollection new
                 into: [ :c :u | "value equivaleny is required"
                     u low = u high ifTrue: [ "redundunt vertex" index at: u put: (index at: u low) ]
                         ifFalse: [ c add: (index at: u low) @ (index at: u high) -> u ].
                     c ].
        oldKey := nil. "unmatchable key"
        q sort: [ :an :bn |
            | a b |
            a := an key.
            b := bn key.
            a x = b x ifTrue: [ a y < b y ] ifFalse: [ a x < b x ] ].
        q traceCr.
        q do: [ :tmp |
            | key u |
            key := tmp key.
            key traceCr.
            u := tmp value.
            self assert: u low ~= u high description: 'this should be deleted'.
            key = oldKey ifTrue: [ index at: u put: nextId "matches existing vervex" ]
                ifFalse: [ "unique vertex"
                    nextId := nextId + 1.
                    u low: (subgraph at: (index at: u low)).
                    u high: (subgraph at: (index at: u high)).
                    index at: u put: nextId.
                    subgraph at: nextId put: u.
                    oldKey := key ] ] ].
    ^ subgraph at: (index at: aNode)
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
