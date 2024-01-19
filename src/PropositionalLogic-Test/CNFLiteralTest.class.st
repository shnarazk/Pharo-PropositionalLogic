Class {
	#name : 'CNFLiteralTest',
	#superclass : 'TestCase',
	#category : 'PropositionalLogic-Test',
	#package : 'PropositionalLogic-Test'
}

{ #category : 'tests' }
CNFLiteralTest >> testAsVar [

	|lit|
	lit := CNFLiteral from: -8.
	self assert: lit asVar equals: 8.
	
]

{ #category : 'tests' }
CNFLiteralTest >> testEncodedValue [

	| lit |
	lit := CNFLiteral from: 8.
	self assert: lit encodedValue equals: 16
]

{ #category : 'tests' }
CNFLiteralTest >> testNegate [

	| lit |
	lit := CNFLiteral from: 1.
	self assert: lit negate encodedValue  equals: 3.
	lit set: 5.
	self assert: lit negate encodedValue equals: 4.
]

{ #category : 'tests' }
CNFLiteralTest >> testSet [

	| lit |
	lit := CNFLiteral from: 8.
	lit set: 11.
	self assert: lit encodedValue equals: 11.
	self should: [ lit set: 0 ] raise: AssertionFailure .
]
