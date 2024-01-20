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
