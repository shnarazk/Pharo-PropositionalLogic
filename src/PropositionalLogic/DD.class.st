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

	<todo: 'normalize'>
	^ self new setGraphFromAssociation: anAssociation; reduce; yourself
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
DD >> compose: aBool as: other [
	"f_1|_{x_i=f_2}"

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

{ #category : 'inspector extensions' }
DD >> inspectionGraph [

	<inspectorPresentationOrder: 10 title: 'Graph'>
	^ SpRoassalPresenter new canvas: self visualize; yourself
]

{ #category : 'initialization' }
DD >> normalize [

	self reduce
]

{ #category : 'algorithm' }
DD >> reduce [
	"reduce to canonical form"

	self subclassResponsibility
]

{ #category : 'algorithm' }
DD >> restrict: varIndex [
	"f|_{x_i=b}"

	self subclassResponsibility
]

{ #category : 'algorithm' }
DD >> restrict: varIndex to: aBool [
	"f|_{x_i=b}"

	self subclassResponsibility
]

{ #category : 'evaluating' }
DD >> satisfyAll [
	"S_f"

	self subclassResponsibility
]

{ #category : 'evaluating' }
DD >> satisfyCount [
	"|S_f|"

	self subclassResponsibility
]

{ #category : 'evaluating' }
DD >> satisfyOne [
	"some element of S_f"

	self subclassResponsibility
]

{ #category : 'initialization' }
DD >> setGraphFromAssociation: anAssociation [

	graph := DDNode newFromAssociation: anAssociation
]

{ #category : 'accessing' }
DD >> size [

	^ graph allNodesSet size
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

	| canvas elements nodes node |
	canvas := RSCanvas new.
	nodes := graph allNodesSet.
	elements := nodes collect: [ :each |
		            node := RSGroup new.
		            node add:
			            (RSEllipse new size: 10; color: Color white; borderColor: Color gray; yourself).
		            node add: (RSLabel new fontSize: 4; text: each literal; yourself).
		            each literal isNumber ifFalse: [
			            each literal ifTrue: [ node color: Color blue ].
			            each literal ifFalse: [ node color: Color black ] ].
		            node asShape model: each; draggable; yourself ].
	node := RSGroup new.
	node add: (RSEllipse new size: 10; color: Color white; borderColor: Color blue; yourself).
	node add: (RSLabel new fontSize: 4; text: 'F'; yourself).
	elements add: (node asShape model: false; draggable; yourself).
	node := RSGroup new.
	node add: (RSEllipse new size: 10; color: Color white; borderColor: Color red; yourself).
	node add: (RSLabel new fontSize: 4; text: 'T'; yourself).
	elements add: (node asShape model: true; draggable; yourself).
	elements := elements as: RSGroup.
	canvas addAll: elements.
	RSLineBuilder line moveBehind; canvas: canvas; width: 1; color: Color red; connectFromAll: [ :each |
			nodes select: [ :n | n high == each ] ].
	RSLineBuilder line moveBehind; canvas: canvas; width: 1; color: Color blue; connectFromAll: [ :each |
			nodes select: [ :n | n low == each ] ].
	RSTreeLayout new on: elements.
	canvas @ RSCanvasController.
	^ canvas canvas
]
