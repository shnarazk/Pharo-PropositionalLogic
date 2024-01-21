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
DDNodeTest >> testNew [

	| node |
	node := DDNode new.
	self assert: node literal equals: nil.
	self assert: node high equals: nil.
	self assert: node low equals: nil
]

{ #category : 'tests' }
DDNodeTest >> testNewFromAssociation [

	| aNode |
	aNode := DDNode newFromAssociation:
		         1 -> { 2 ->{  true .  false}  . 3 -> { false . true } }.
	self assert: aNode literal equals: 1
]
