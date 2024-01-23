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

	bottom ifNil: [
		bottom := self new literal: false;
			          yourself ].
	^ bottom
]

{ #category : 'private' }
DDNode class >> from: anAssociationOrBool after: anId [

	^ anAssociationOrBool isAssociation
		  ifTrue: [
			  | aLiteral subtree |
			  self assert: [ anId < anAssociationOrBool key ] description: 'Indices are out of order'.
			  aLiteral := anAssociationOrBool key.
			  subtree := anAssociationOrBool value.
			  self new literal: aLiteral;
				  low: (self from: (subtree at: 1) after: aLiteral);
				  high: (self from: (subtree at: 2) after: aLiteral);
				  yourself ]
		  ifFalse: [
			  anAssociationOrBool ifTrue: [ self top ]
				  ifFalse: [ self bottom ] ]
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

	top ifNil: [
		top := self new literal: true;
			       yourself ].
	^ top
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
		node low ifNotNil: [ queue addLast: node low ].
		node high ifNotNil: [ queue addLast: node high ] ].
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
		node low ifNotNil: [ queue addLast: node low ].
		node high ifNotNil: [ queue addLast: node high ] ].

]

{ #category : 'initialization' }
DDNode >> setIndex [
	"assign an integer to each node in width-first order. and return the last used index"

	| n queue |
	"For a graph, not a tree, we have to traverse each node once at most. So reset them to nil first."
	self resetIndex.
	n := 1.
	queue := OrderedCollection new.
	queue addLast: self.
	[ 0 < queue size ] whileTrue: [
		| node |
		node := queue removeFirst.
		node index ifNil: [
			node index: n.
			n := n + 1.
			node low ifNotNil: [ queue addLast: node low ].
			node high ifNotNil: [ queue addLast: node high ] ] ].
	^ n
]

{ #category : 'constants' }
DDNode >> top [

	^ self class top
]

{ #category : 'accessing' }
DDNode >> varIndex [

	^ literal abs
]
