Class {
	#name : 'CNFLiteral',
	#superclass : 'Object',
	#instVars : [
		'encoded'
	],
	#category : 'PropositionalLogic',
	#package : 'PropositionalLogic'
}

{ #category : 'instance creation' }
CNFLiteral class >> from: anInt [

	^ self new set: (anInt < 0 ifTrue: [ -2 * anInt + 1 ]
				   ifFalse: [ 2 * anInt ]); yourself
]

{ #category : 'accessing' }
CNFLiteral >> asVar [

	^ encoded // 2
]

{ #category : 'accessing' }
CNFLiteral >> encodedValue [

	^ encoded
]

{ #category : 'accessing' }
CNFLiteral >> negate [

	^ self class new set: (encoded  odd ifTrue: [ encoded - 1 ] ifFalse: [encoded  + 1])
]

{ #category : 'accessing' }
CNFLiteral >> set: anEncodedValue [

	self assert: [ anEncodedValue ~~ 0 ] description: '0 cannot be encoded to literal'.
	encoded := anEncodedValue
]
