"
Graph structure for decision diagram
"
Class {
	#name : 'DDNode',
	#superclass : 'Object',
	#instVars : [
		'id',
		'high',
		'low'
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

{ #category : 'instance creation' }
DDNode class >> from: aDictionary [
	"return a tree of DDNodes corresponding to aDictionary (from #id to #high and #low)"

	^ self from: aDictionary after: 0
]

{ #category : 'instance creation' }
DDNode class >> from: aDictionary after: anId [

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

	^ id = other id and: [ high = other high and: [ low = other low ] ]
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

	aDictionary at: id put: {
			high.
			low }.
	high ifNotNil: [ high foldInto: aDictionary ].
	low ifNotNil: [ low foldInto: aDictionary ].
	^ aDictionary
]

{ #category : 'comparing' }
DDNode >> hash [

	^ id hash bitXor: (high hash bitXor: low hash)
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
DDNode >> id [

	^ id
]

{ #category : 'accessing' }
DDNode >> id: anObject [

	id := anObject
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
