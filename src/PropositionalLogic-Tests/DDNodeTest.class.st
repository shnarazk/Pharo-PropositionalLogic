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
	graph setIndex
]

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

{ #category : 'tests' }
DDNodeTest >> testSetIndex [

	| nodes indices |
	graph setIndex.
	nodes := graph allNodesSet.
	indices := nodes collect: [ :each | each index ].
	self assert: graph index equals: nodes size + 2.
	(1 to: nodes size) allSatisfy: [ :each | nodes includes: each ]
]
