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

{ #category : 'comparing' }
DDNode >> = other [

	^ literal = other literal and: [ high = other high and: [ low = other low ] ]
]

{ #category : 'constants' }
DDNode >> bottom [

	^ self class bottom
]

{ #category : 'converting' }
DDNode >> flattened [

	^ self foldInto: Set new
]

{ #category : 'converting' }
DDNode >> foldInto: aSet [

	aSet add: self.
	low ifNotNil: [ low foldInto: aSet ].
	high ifNotNil: [ high foldInto: aSet ].
	^ aSet
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
