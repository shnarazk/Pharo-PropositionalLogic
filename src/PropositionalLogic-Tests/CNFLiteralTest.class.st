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
	self assert: lit4 literalIndex equals: 8.
	self assert: lit_4 literalIndex equals: 9.
	lit := CNFLiteral @ 8.
	self assert: lit literalIndex equals: 16
]

{ #category : 'tests' }
CNFLiteralTest >> testNegated [

	| lit |
	lit := CNFLiteral @ 1.
	self assert: lit negated literalIndex equals: 3.
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
