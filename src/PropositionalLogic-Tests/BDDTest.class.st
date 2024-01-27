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
    bdd := DDBuilder majority2.
    bdd reduce.
    self assert: bdd size equals: 4.
    bdd reduce.
    self assert: bdd size equals: 4
]
