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

    | f1 f2 result |
    f1 := DDBuilder app1 asBDD .
    self assert: f1 size equals: 2.
    f2 := DDBuilder app2 asBDD.
    self assert: f2 size equals: 2.
    result := f1 or: f2.
    self assert: result size equals: 3
]

{ #category : 'tests' }
BDDTest >> testComposeGraphLowHighAndWithMappingWithValue [

    | f1 f2 result |
    f1 := DDBuilder app1 asBDD.
    self assert: f1 size equals: 2.
    f2 := DDBuilder app2 asBDD.
    self assert: f2 size equals: 2.
    result := f1 compose: f2 at: 1.
    self assert: result size equals: 3
]

{ #category : 'tests' }
BDDTest >> testReduce [

    | bdd nodes |
    bdd := DDBuilder majority asBDD.
    self assert: bdd size equals: 4.
    bdd reduce.
    self assert: bdd size equals: 4.
    bdd := DDBuilder independent asBDD.
    nodes := bdd graph allNodesSet asOrderedCollection.
    self assert: (nodes select: [ :each | each varIndex = 3 ]) size equals: 3.
    self assert: (nodes select: [ :each | each varIndex = 4 ]) size equals: 4.
    self assert: (nodes select: [ :each | each varIndex = 5 ]) size equals: 3.
    self assert: (nodes select: [ :each | each varIndex = 6 ]) size equals: 1
]
