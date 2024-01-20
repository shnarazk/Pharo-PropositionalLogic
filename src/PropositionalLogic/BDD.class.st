"
Binary Decision Diagram
"
Class {
	#name : 'BDD',
	#superclass : 'DD',
	#instVars : [
		'graph'
	],
	#category : 'PropositionalLogic',
	#package : 'PropositionalLogic'
}

{ #category : 'comparing' }
BDD >> = other [

	^ graph = other graph
]

{ #category : 'accessing' }
BDD >> graph [

	^ graph
]

{ #category : 'accessing' }
BDD >> graph: anObject [

	graph := anObject
]

{ #category : 'comparing' }
BDD >> hash [

	^ graph hash
]
