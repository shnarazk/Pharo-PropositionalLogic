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

{ #category : 'tests' }
CNFLiteralTest >> testAsIndex [

	|lit|
	lit := CNFLiteral from: -8.
	self assert: lit asIndex equals: 8.
	
]

{ #category : 'tests' }
CNFLiteralTest >> testEncodedValue [

	| lit |
	self assert: lit4 encodedValue equals: 8.
	self assert: lit_4 encodedValue equals: 9.
	lit := CNFLiteral from: 8.
	self assert: lit encodedValue equals: 16
]

{ #category : 'tests' }
CNFLiteralTest >> testNegated [

	| lit |
	lit := CNFLiteral from: 1.
	self assert: lit negated encodedValue equals: 3.
	lit set: 5.
	self assert: lit negated encodedValue equals: 4.
	self assert: lit_4 negated negated equals: lit_4
]

{ #category : 'tests' }
CNFLiteralTest >> testSet [

	| lit |
	lit := CNFLiteral from: 8.
	lit set: 11.
	self assert: lit encodedValue equals: 11.
	self should: [ lit set: 0 ] raise: AssertionFailure .
]
