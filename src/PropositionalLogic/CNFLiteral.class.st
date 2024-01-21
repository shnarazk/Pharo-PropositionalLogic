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
CNFLiteral class >> @ aliteral [
	"Make a literal from an integer literal"

	"(CNFLiteral @ 4) literalIndex >>> 8"

	"(CNFLiteral @ -4) literalIndex >>> 9"

	^ self new set: (aliteral < 0 ifTrue: [ -2 * aliteral + 1 ]
				   ifFalse: [ 2 * aliteral ]);
		  yourself
]

{ #category : 'instance creation' }
CNFLiteral class >> newFrom: aliteral [

	^ self @ aliteral
]

{ #category : 'comparing' }
CNFLiteral >> = other [

	^ encoded = other literalIndex
]

{ #category : 'testing' }
CNFLiteral >> isSatisfiedUnder: anAssignment [

	^ self value = (anAssignment valueOfVar: self varIndex)
]

{ #category : 'accessing' }
CNFLiteral >> literalIndex [

	^ encoded
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

{ #category : 'evaluating' }
CNFLiteral >> value [
	"return bool"

	^ encoded even
]

{ #category : 'accessing' }
CNFLiteral >> varIndex [
	"return an integer corresponding to var index of me"

	^ encoded // 2
]
