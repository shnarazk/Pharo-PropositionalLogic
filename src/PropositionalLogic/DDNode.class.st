"
Graph structure for decision diagram
"
Class {
	#name : 'DDNode',
	#superclass : 'Object',
	#instVars : [
		'high',
		'low',
		'varIndex'
	],
	#category : 'PropositionalLogic-DecisionDiagram',
	#package : 'PropositionalLogic',
	#tag : 'DecisionDiagram'
}

{ #category : 'private' }
DDNode class >> from: anAssociation after: anId [
	"make a non-terminate node(self)"

	| aLiteral node low high |
	self assert: anAssociation isAssociation description: 'first argmument is not an association'.
	self assert: [ anId < anAssociation key ] description: 'Indices are out of order'.
	aLiteral := anAssociation key.
	low := anAssociation value at: 1.
	high := anAssociation value at: 2.
	node := self new varIndex: aLiteral; yourself.
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

{ #category : 'converting' }
DDNode >> allNodesSet [
    "return the subnodes under me as a set"

    | queue aSet |
    queue := OrderedCollection new.
    aSet := Set new.
    queue addLast: self.
    [ 0 < queue size ] whileTrue: [
        | node |
        node := queue removeFirst.
        aSet add: node.
        node low isLiteral ifFalse: [ queue addLast: node low ].
        node high isLiteral ifFalse: [ queue addLast: node high ] ].
    ^ aSet
]

{ #category : 'private' }
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
DDNode >> low [

	^ low
]

{ #category : 'accessing' }
DDNode >> low: anObject [

	low := anObject
]

{ #category : 'accessing' }
DDNode >> varIndex [

    ^ varIndex
]

{ #category : 'accessing' }
DDNode >> varIndex: anInt [

    varIndex := anInt
]
