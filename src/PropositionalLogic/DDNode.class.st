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

	bottom ifNil: [ top := OrderedCollection new ].
	^ bottom
]

{ #category : 'instance creation' }
DDNode class >> from: aDictionary [

	^ aDictionary
		  at: #value
		  ifPresent: [ :aBool |
			  aBool ifTrue: [ self top ]
				  ifFalse: [ self bottom ] ]
		  ifAbsent: [
			  self new high: (self from: (aDictionary at: #high));
				  low: (self from: (aDictionary at: #low));
				  yourself ]
]

{ #category : 'constants' }
DDNode class >> top [

	top ifNil: [ top := OrderedCollection new ].
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
