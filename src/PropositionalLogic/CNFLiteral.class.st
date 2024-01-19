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

	^ self new set: (anInt < 0 ifTrue: [ 2 * anInt ]
				   ifFalse: [ 2 * anInt + 1 ]); yourself
]

{ #category : 'accessing' }
CNFLiteral >> encodedValue [

	^ encoded
]

{ #category : 'accessing' }
CNFLiteral >> set: anEncodedValue [

	encoded := anEncodedValue
]
