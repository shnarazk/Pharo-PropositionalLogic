Class {
	#name : 'DDNode',
	#superclass : 'Object',
	#instVars : [
		'id',
		'high',
		'low'
	],
	#category : 'PropositionalLogic',
	#package : 'PropositionalLogic'
}

{ #category : 'comparing' }
DDNode >> = other [

	^ id = other id and: [ high = other high and: [ low = other low ] ]
]

{ #category : 'accessing' }
DDNode >> decode [

	| val |
	val := self id.
	^ val odd ifTrue: [ val / 2 ]
		  ifFalse: [ (val / 2) negated ]
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
