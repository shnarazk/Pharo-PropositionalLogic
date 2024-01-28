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
BDDTest >> testApplyOnAndWithMappingWithValue [

    | f1 f2 |
    f1 := DDBuilder app1.
    self assert: f1 size equals: 2.
    f2 := DDBuilder app2.
    self assert: f2 size equals: 2.
    f1 or: f2.
    self assert: f1 size equals: 3
]

{ #category : 'tests' }
BDDTest >> testApplyOnAndWithmapping [

    | f1 f2 |
    f1 := DDBuilder app1.
    self assert: f1 size equals: 2.
    f2 := DDBuilder app2.
    self assert: f2 size equals: 2.
    f1 or: f2.
    self assert: f1 size equals: 3
]

{ #category : 'tests' }
BDDTest >> testComposeGraphLowHighAndWithMappingWithValue [

	self flag: #toImplement.
	self assert: false
]

{ #category : 'tests' }
BDDTest >> testReduce [

    | bdd |
    bdd := DDBuilder majority2.
    bdd reduce.
    self assert: bdd size equals: 4.
    bdd reduce.
    self assert: bdd size equals: 4
]
