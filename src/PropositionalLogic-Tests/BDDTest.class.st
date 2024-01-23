"
A BDDTest is a test class for testing the behavior of BDD
"
Class {
	#name : 'BDDTest',
	#superclass : 'TestCase',
	#category : 'PropositionalLogic-Tests',
	#package : 'PropositionalLogic-Tests'
}

{ #category : 'tests' }
BDDTest >> testReduce [

	| bdd |
	bdd := DDBuilder majority.
	bdd reduce.
	self assert: false
]
