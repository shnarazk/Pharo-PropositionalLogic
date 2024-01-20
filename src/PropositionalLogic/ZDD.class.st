"
Zero-suppressed Decision Diagram
"
Class {
	#name : 'ZDD',
	#superclass : 'DD',
	#instVars : [
		'graph'
	],
	#category : 'PropositionalLogic',
	#package : 'PropositionalLogic'
}

{ #category : 'comparing' }
ZDD >> = other [

	^ graph = other graph
]

{ #category : 'accessing' }
ZDD >> graph [

	^ graph
]

{ #category : 'accessing' }
ZDD >> graph: anObject [

	graph := anObject
]

{ #category : 'comparing' }
ZDD >> hash [

	^ graph hash
]
