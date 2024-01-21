"
Graph structure for decision diagram
"
Class {
	#name : 'DDNode',
	#superclass : 'Object',
	#instVars : [
		'high',
		'low',
		'literal'
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
		bottom := self new literalIndex: false;
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
				  high: (self from: (subtree at: 1) after: aLiteral);
				  low: (self from: (subtree at: 2) after: aLiteral + 1);
				  yourself ]
		  ifFalse: [
			  anAssociationOrBool ifTrue: [ self top ]
				  ifFalse: [ self bottom ] ]
]

{ #category : 'instance creation' }
DDNode class >> newFromAssociation: aTree [
	"return a tree of DDNodes corresponding to an association tree (from #id to #high and #low)"

	^ self from: aTree after: 0
]

{ #category : 'constants' }
DDNode class >> top [

	top ifNil: [
		top := self new literalIndex: true;
			       yourself ].
	^ top
]

{ #category : 'comparing' }
DDNode >> = other [

	^ literal = other id and: [ high = other high and: [ low = other low ] ]
]

{ #category : 'constants' }
DDNode >> bottom [

	^ self class bottom
]

{ #category : 'accessing' }
DDNode >> decode [

	| val |
	val := self id.
	^ val odd ifTrue: [ val / 2 ]
		  ifFalse: [ (val / 2) negated ]
]

{ #category : 'converting' }
DDNode >> flattened [

	^ self foldInto: Dictionary new
]

{ #category : 'converting' }
DDNode >> foldInto: aDictionary [

	aDictionary at: literal put: {
			high.
			low }.
	high ifNotNil: [ high foldInto: aDictionary ].
	low ifNotNil: [ low foldInto: aDictionary ].
	^ aDictionary
]

{ #category : 'comparing' }
DDNode >> hash [

	^ literal hash bitXor: (high hash bitXor: low hash)
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
DDNode >> literal [

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

{ #category : 'constants' }
DDNode >> top [

	^ self class top
]

{ #category : 'accessing' }
DDNode >> varIndex [

	^ literal abs
]
