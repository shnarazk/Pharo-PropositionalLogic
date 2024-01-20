"
A DDNodeTest is a test class for testing the behavior of DDNode
"
Class {
	#name : 'DDNodeTest',
	#superclass : 'TestCase',
	#category : 'PropositionalLogic-Tests',
	#package : 'PropositionalLogic-Tests'
}

{ #category : 'tests' }
DDNodeTest >> testFrom [

	| aDictionary aNode |
	self notYetImplemented
]

{ #category : 'tests' }
DDNodeTest >> testNew [

	| node |
	node := DDNode new.
	self assert: node id equals: nil.
	self assert: node high equals: nil.
	self assert: node low equals: nil
]

{ #category : 'tests' }
DDNodeTest >> testNewFromAssociation [

	| aNode |
	aNode := DDNode newFromAssociation:
		         { (1 -> { (2 -> true , -2 -> false) } , -1 -> { (2 -> false , 3 -> true) }) }.
	self assert: aNode literalIndex equals: 2
]
