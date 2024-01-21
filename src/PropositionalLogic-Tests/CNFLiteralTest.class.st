Class {
	#name : 'CNFLiteralTest',
	#superclass : 'TestCase',
	#instVars : [
		'lit4',
		'lit_4'
	],
	#category : 'PropositionalLogic-Tests',
	#package : 'PropositionalLogic-Tests'
}

{ #category : 'running' }
CNFLiteralTest >> setUp [

	super setUp.
	lit4 := CNFLiteral @ 4.
	lit_4 := CNFLiteral @ -4
]

{ #category : 'tests' }
CNFLiteralTest >> testAsIndex [

	|lit|
	lit := CNFLiteral @ -8.
	self assert: lit varIndex equals: 8.
	
]

{ #category : 'tests' }
CNFLiteralTest >> testEncodedValue [

	| lit |
	self assert: lit4 literalIndex equals: 9.
	self assert: lit_4 literalIndex equals: 8.
	lit := CNFLiteral @ 8.
	self assert: lit literalIndex equals: 17
]

{ #category : 'tests' }
CNFLiteralTest >> testIsSatisfiedUnder [

	| anAssignment |
	anAssignment := CNFAssignment newFrom: {
			                (1 -> true).
			                (2 -> true).
			                (3 -> false).
			                (4 -> true) }.
	self assert: (lit4 isSatisfiedUnder: anAssignment) equals: true.
	self assert: (lit_4 isSatisfiedUnder: anAssignment) equals: false
]

{ #category : 'tests' }
CNFLiteralTest >> testLiteralIndex [

	self assert: lit4 literalIndex equals: 9.
	self assert: lit_4 literalIndex equals: 8.
]

{ #category : 'tests' }
CNFLiteralTest >> testNegated [

	| lit |
	lit := CNFLiteral @ 1.
	self assert: lit negated literalIndex equals: 2.
	lit set: 5.
	self assert: lit negated literalIndex equals: 4.
	self assert: lit_4 negated negated equals: lit_4
]

{ #category : 'tests' }
CNFLiteralTest >> testSet [

	| lit |
	lit := CNFLiteral @ 8.
	lit set: 11.
	self assert: lit literalIndex equals: 11.
	self should: [ lit set: 0 ] raise: AssertionFailure .
]

{ #category : 'tests' }
CNFLiteralTest >> testValue [

	self assert: lit4 value equals: true.
	self assert: lit_4 value equals: false
]

{ #category : 'tests' }
CNFLiteralTest >> testVarIndex [

	self assert: lit4 varIndex equals: 4.
	self assert: lit_4 varIndex equals: 4
]
