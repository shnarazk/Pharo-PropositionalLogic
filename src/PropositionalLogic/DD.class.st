"
I am an abstruct class for decision diagram.
Index is supposed to be encoded by _literal encoding_.
"
Class {
	#name : 'DD',
	#superclass : 'Object',
	#instVars : [
		'graph'
	],
	#category : 'PropositionalLogic',
	#package : 'PropositionalLogic'
}

{ #category : 'instance creation' }
DD class >> FromTree: aDictionary [

	^ self new setGraphFromTree: aDictionary;
		  yourself
]

{ #category : 'accessing' }
DD class >> bottom [
	"return ⊥"

	^ self new graph: DDNode bottom
]

{ #category : 'accessing' }
DD class >> top [
	"return top"

	^ self new graph: DDNode top
]

{ #category : 'comparing' }
DD >> = other [

	^ graph = other graph
]

{ #category : 'adding' }
DD >> add: otherDD [

	self subclassResponsibility
]

{ #category : 'accessing' }
DD >> bottom [

	^ self class bottom
]

{ #category : 'evaluating' }
DD >> canCompress: aNode [
	"return whether aNode is compressable"

	self subclassResponsibility
]

{ #category : 'accessing' }
DD >> graph [

	^ graph
]

{ #category : 'accessing' }
DD >> graph: anObject [

	graph := anObject
]

{ #category : 'comparing' }
DD >> hash [

	^ graph hash
]

{ #category : 'initialization' }
DD >> setGraphFromTree: aDictionary [

	graph := DDNode from: aDictionary
]

{ #category : 'accessing' }
DD >> top [

	^ self class top
]

{ #category : 'accessing' }
DD >> valueUnder: anAssignment [
	"return bool"

	<TODO: 'Is this a good name'>
	self notYetImplemented
]

{ #category : 'drawing - roassal' }
DD >> visualize [

	| canvas elements |
	canvas := RSCanvas new.
	elements := (graph flattened values collect: [:each| RSEllipse new size: 5; yourself ]) as: RSGroup .
	canvas addAll: elements .
	RSTreeLayout  new on: elements .
	canvas @ RSCanvasController.
	^ canvas canvas
]
