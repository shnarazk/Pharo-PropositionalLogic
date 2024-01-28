"
A DDNodeTest is a test class for testing the behavior of DDNode
"
Class {
	#name : 'DDNodeTest',
	#superclass : 'TestCase',
	#instVars : [
		'graph'
	],
	#category : 'PropositionalLogic-Tests',
	#package : 'PropositionalLogic-Tests'
}

{ #category : 'running' }
DDNodeTest >> setUp [

	graph := (BDD newFromAssociation: 1 -> {
			          (2 -> {
				           false.
				           (3 -> { false. true }) }).
			          (2 -> {
				           (3 -> { false. true }).
				           true }) }) graph.

]

{ #category : 'tests' }
DDNodeTest >> testNew [

	| node |
	node := DDNode new.
	self assert: node varIndex equals: nil.
	self assert: node high equals: nil.
	self assert: node low equals: nil
]

{ #category : 'tests' }
DDNodeTest >> testNewFromAssociation [

	| aNode |
	aNode := DDNode newFromAssociation:
		         1 -> { 2 ->{  true .  false}  . 3 -> { false . true } }.
	self assert: aNode varIndex equals: 1
]
