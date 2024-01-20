"
Encoded literal
"
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
	"Make a literal from an integer"

	"(CNFLiteral from: 4) encodedValue >>> 8"
	"(CNFLiteral from: -4) encodedValue >>> 9"

	^ self new set: (anInt < 0 ifTrue: [ -2 * anInt + 1 ]
				   ifFalse: [ 2 * anInt ]);
		  yourself
]

{ #category : 'comparing' }
CNFLiteral >> = other [

	^ encoded = other encodedValue
]

{ #category : 'accessing' }
CNFLiteral >> asBoolean [

	^ encoded even
]

{ #category : 'accessing' }
CNFLiteral >> asIndex [
	"return an integer corresponding to var index of me"

	^ encoded // 2
]

{ #category : 'accessing' }
CNFLiteral >> encodedValue [

	^ encoded
]

{ #category : 'testing' }
CNFLiteral >> isSatisfiedUnder: anAssignment [

	^ self asBoolean = (anAssignment valueFor: self asIndex)
]

{ #category : 'accessing' }
CNFLiteral >> negated [

	^ self class new set: (encoded  odd ifTrue: [ encoded - 1 ] ifFalse: [encoded  + 1])
]

{ #category : 'accessing' }
CNFLiteral >> set: anEncodedValue [

	self assert: [ anEncodedValue ~~ 0 ] description: '0 cannot be encoded to literal'.
	encoded := anEncodedValue
]
