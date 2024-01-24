"
Graph structure for decision diagram
"
Class {
	#name : 'DDNode',
	#superclass : 'Object',
	#instVars : [
		'high',
		'low',
		'literal',
		'index',
		'mark'
	],
	#classInstVars : [
		'top',
		'bottom'
	],
	#category : 'PropositionalLogic',
	#package : 'PropositionalLogic'
}

{ #category : 'constants' }
DDNode class >> bottom [

	^ false
]

{ #category : 'private' }
DDNode class >> from: anAssociation after: anId [
	"make a non-terminate node(self)"

	| aLiteral node low high |
	self assert: anAssociation isAssociation description: 'first argmument is not an association'.
	self assert: [ anId < anAssociation key ] description: 'Indices are out of order'.
	aLiteral := anAssociation key.
	low := anAssociation value at: 1.
	high := anAssociation value at: 2.
	node := self new literal: aLiteral; yourself.
	node low: (low isAssociation ifTrue: [ self from: low after: aLiteral ]
			 ifFalse: [ low ]).
	node high: (high isAssociation ifTrue: [ self from: high after: aLiteral ]
			 ifFalse: [ high ]).
	^ node
]

{ #category : 'instance creation' }
DDNode class >> newFromAssociation: aTree [
	"return a tree of DDNodes corresponding to an association tree (from #id to #low and #high)"

	^ self from: aTree after: 0
]

{ #category : 'class initialization' }
DDNode class >> reset [
	"reset top and bottom"

	top := nil.
	bottom := nil
]

{ #category : 'constants' }
DDNode class >> top [

	^ true
]

{ #category : 'converting' }
DDNode >> allNodesSet [
	"return the sub nodes under me as a set"

	| queue aSet |
	queue := OrderedCollection new.
	aSet := Set  new.
	queue addLast: self.
	[ 0 < queue size ] whileTrue: [
		| node |
		node := queue removeFirst.
		aSet add: node.
		node low isLiteral ifFalse: [ queue addLast: node low ].
		node high isLiteral ifFalse: [ queue addLast: node high ] ].
	^ aSet
]

{ #category : 'constants' }
DDNode >> bottom [

	^ self class bottom
]

{ #category : 'converting' }
DDNode >> foldInto: aSet [

	aSet add: self.
	low ifNotNil: [ low foldInto: aSet ].
	high ifNotNil: [ high foldInto: aSet ].
	^ aSet
]

{ #category : 'accessing' }
DDNode >> high [

	^ high
]

{ #category : 'accessing' }
DDNode >> high: anObject [

	high := anObject
]

{ #category : 'as yet unclassified' }
DDNode >> highIndex [

	^ high isLiteral
		  ifTrue: [
			  high ifFalse: [ 1 ]
				  ifTrue: [ 2 ] ]
		  ifFalse: [ high index ]
]

{ #category : 'accessing' }
DDNode >> index [

	^ index
]

{ #category : 'accessing' }
DDNode >> index: anObject [

	index := anObject
]

{ #category : 'accessing' }
DDNode >> literal [
	"This field contains a integeridentifier which is unique to that vertex in the graph. It does not
	matter how the identifiers are ordered among the
	vertices, only that they range from 1 up to the number of vertices and that they all be different."

	^ literal
]

{ #category : 'accessing' }
DDNode >> literal: anObject [

	literal := anObject
]

{ #category : 'accessing' }
DDNode >> low [

	^ low
]

{ #category : 'accessing' }
DDNode >> low: anObject [

	low := anObject
]

{ #category : 'as yet unclassified' }
DDNode >> lowIndex [

	^ low isLiteral
		  ifTrue: [
			  low ifFalse: [ 1 ]
				  ifTrue: [ 2 ] ]
		  ifFalse: [ low index ]
]

{ #category : 'accessing' }
DDNode >> mark [
	"This is used to mark which vertices have been visited during a traversal of the graph."

	^ mark
]

{ #category : 'accessing' }
DDNode >> mark: anObject [

	mark := anObject
]

{ #category : 'private' }
DDNode >> resetIndex [

	| queue |
	queue := OrderedCollection new.
	queue addLast: self.
	[ 0 < queue size ] whileTrue: [
		| node |
		node := queue removeFirst.
		node index: nil.
		self assert: node low isNotNil description: 'low must point to another node or a boolean'.
		self assert: node high isNotNil description: 'high must point to another node or a boolean'.
		node low isLiteral ifFalse: [ queue addLast: node low ].
		node high isLiteral ifFalse: [ queue addLast: node high ] ]
]

{ #category : 'initialization' }
DDNode >> setIndex [
	"assign an integer to each non-terminal node in width-first order. and return the last used index"

	| n queue nodes |
	"For a graph, not a tree, we have to traverse each node once at most. So reset them to nil first."
	self resetIndex.
	"assign 1 to the terminal node false, and 2 to the terminal node true,"
	n := 2.
	queue := OrderedCollection new.
	nodes := Set new.
	queue addLast: self.
	[ 0 < queue size ] whileTrue: [
		| node |
		node := queue removeFirst.
		node index ifNil: [
			n := n + 1.
			node index: n.
			nodes add: node.
			node low isLiteral ifFalse: [ queue addLast: node low ].
			node high isLiteral ifFalse: [ queue addLast: node high ] ] ].
	"Then relabel to start from leaves to root"
	nodes do: [ :each | each index: n - each index + 3].
	^ n - 3
]

{ #category : 'constants' }
DDNode >> top [

	^ self class top
]

{ #category : 'accessing' }
DDNode >> varIndex [

	^ literal abs
]
