"
Graph structure for decision diagram
"
Class {
	#name : 'DDNode',
	#superclass : 'Object',
	#instVars : [
		'high',
		'low',
		'literalIndex'
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
		bottom := self new
			          id: false;
			          yourself ].
	^ bottom
]

{ #category : 'private' }
DDNode class >> from: aDictionary after: anId [

	<TODO: 'argument type was changed'>
	^ aDictionary
		  at: #value
		  ifPresent: [ :aBool |
			  aBool ifTrue: [ self top ]
				  ifFalse: [ self bottom ] ]
		  ifAbsent: [
			  | aLiteralIndex |
			  self assert: [ anId < (aDictionary at: #id) ] description: 'Indices are out of order'.
			  aLiteralIndex := aDictionary at: #id.
			  self new id: aLiteralIndex;
				  high: (self from: (aDictionary at: #high) after: aLiteralIndex);
				  low: (self from: (aDictionary at: #low) after: aLiteralIndex + 1);
				  yourself ]
]

{ #category : 'instance creation' }
DDNode class >> newFromAssociation: aTree [
	"return a tree of DDNodes corresponding to an association tree (from #id to #high and #low)"

	^ self from: aTree after: 0
]

{ #category : 'constants' }
DDNode class >> top [

	top ifNil: [
		top := self new
			       id: true;
			       yourself ].
	^ top
]

{ #category : 'comparing' }
DDNode >> = other [

	^ literalIndex = other id and: [ high = other high and: [ low = other low ] ]
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

{ #category : 'as yet unclassified' }
DDNode >> flattened [

	^ self foldInto: Dictionary new
]

{ #category : 'as yet unclassified' }
DDNode >> foldInto: aDictionary [

	aDictionary at: literalIndex put: {
			high.
			low }.
	high ifNotNil: [ high foldInto: aDictionary ].
	low ifNotNil: [ low foldInto: aDictionary ].
	^ aDictionary
]

{ #category : 'comparing' }
DDNode >> hash [

	^ literalIndex hash bitXor: (high hash bitXor: low hash)
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
DDNode >> literalIndex [

	^ literalIndex
]

{ #category : 'accessing' }
DDNode >> literalIndex: anInt [

	literalIndex := anInt
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

	^ literalIndex // 2
]
