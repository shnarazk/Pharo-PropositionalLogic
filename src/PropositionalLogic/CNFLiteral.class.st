"
Encoded literal
"
Class {
	#name : 'CNFLiteral',
	#superclass : 'Object',
	#instVars : [
		'encoded'
	],
	#category : 'PropositionalLogic-Satisfiability',
	#package : 'PropositionalLogic',
	#tag : 'Satisfiability'
}

{ #category : 'instance creation' }
CNFLiteral class >> @ aliteral [
	"Make a literal from an integer literal.
	Literal Encoding is a positive occurence of var v is mapped to `2 * v + 1`.
	And a negative occurence of var v (-v) is mapped to `2 * v`."

	"(CNFLiteral @ 4) literalIndex >>> 9"

	"(CNFLiteral @ -4) literalIndex >>> 8"

	^ self new set: (aliteral < 0 ifTrue: [ -2 * aliteral ]
				   ifFalse: [ 2 * aliteral + 1 ]);
		  yourself
]

{ #category : 'instance creation' }
CNFLiteral class >> newFrom: aliteral [
	"an  alias of `@`"

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

{ #category : 'converting' }
CNFLiteral >> literalIndex [

	^ encoded
]

{ #category : 'accessing' }
CNFLiteral >> negated [

	^ self class new set: (encoded  odd ifTrue: [ encoded - 1 ] ifFalse: [encoded  + 1])
]

{ #category : 'private' }
CNFLiteral >> set: anEncodedValue [

	self assert: [ anEncodedValue ~~ 0 ] description: '0 cannot be encoded to literal'.
	encoded := anEncodedValue
]

{ #category : 'converting' }
CNFLiteral >> value [
	"return bool"

	^ encoded odd
]

{ #category : 'converting' }
CNFLiteral >> varIndex [
	"return an integer corresponding to var index of me"

	^ encoded // 2
]
