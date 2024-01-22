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

{ #category : 'accessing' }
DD class >> bottom [
	"return ⊥"

	^ self new graph: DDNode bottom
]

{ #category : 'instance creation' }
DD class >> newFromAssociation: anAssociation [

	^ self new setGraphFromAssociation: anAssociation;
		  normalize;
		  yourself
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

{ #category : 'algorithm' }
DD >> apply: other [

	self subclassResponsibility
]

{ #category : 'accessing' }
DD >> bottom [

	^ self class bottom
]

{ #category : 'algorithm' }
DD >> compose: x1 and: x2 [

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
DD >> normalize [

	self reduce
]

{ #category : 'algorithm' }
DD >> reduce [

	self subclassResponsibility
]

{ #category : 'algorithm' }
DD >> restrict: varIndex [

	self subclassResponsibility
]

{ #category : 'evaluating' }
DD >> satisfyAll [

	self subclassResponsibility
]

{ #category : 'evaluating' }
DD >> satisfyCount [

	self subclassResponsibility
]

{ #category : 'evaluating' }
DD >> satisfyOne [

	self subclassResponsibility
]

{ #category : 'initialization' }
DD >> setGraphFromAssociation: anAssociation [

	graph := DDNode newFromAssociation: anAssociation
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
	"Draw top as a blue elipsse and bottom as a black one."

	| canvas elements nodes |
	canvas := RSCanvas new.
	nodes := graph flattened.
	elements := (nodes collect: [ :each |
		             | node |
		             node := RSEllipse new size: 5;
			                     model: each;
			                     yourself.
		             each literal isNumber ifFalse: [
			             each literal ifTrue: [ node color: Color blue ].
			             each literal ifFalse: [ node color: Color black ] ].
		             node ]) as: RSGroup.
	canvas addAll: elements.
	RSLineBuilder line canvas: canvas;
		width: 1;
		color: Color blue;
		connectFromAll: [ :each | nodes select: [ :n | n high == each ] ].
	RSLineBuilder line canvas: canvas;
		width: 1;
		color: Color red;
		connectFromAll: [ :each | nodes select: [ :n | n low == each ] ].
	RSTreeLayout new on: elements.
	canvas @ RSCanvasController.
	^ canvas canvas
]
