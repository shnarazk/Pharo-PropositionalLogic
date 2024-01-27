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
DD class >> newFromAssociation: anAssociation [

	<todo: 'normalize'>
	^ self new setGraphFromAssociation: anAssociation; reduce; yourself
]

{ #category : 'comparing' }
DD >> = other [

	^ graph = other graph
]

{ #category : 'algorithm' }
DD >> apply: operator with: otherDD withControllingValue: aBool [

	self subclassResponsibility
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

{ #category : 'algorithm' }
DD >> reduce [
    "reduce to canonical form"

    self reduce: graph
]

{ #category : 'algorithm' }
DD >> reduce: aGraph [
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
DD >> valueUnder: anAssignment [
	"return bool"

	<TODO: 'Is this a good name'>
	self notYetImplemented
]

{ #category : 'drawing - roassal' }
DD >> visualize [
    "Draw top as a blue elipsse and bottom as a black one."

    | canvas elements nodes node |
    nodes := graph allNodesSet.
    elements := nodes collect: [ :each |
                    node := RSGroup new.
                    node add:
                        (RSEllipse new size: 10; color: Color white; borderColor: Color gray;
                                 yourself).
                    node translateBy: 0 @ -1; add:
                            (RSLabel new fontSize: 4; text: each literal; yourself).
                    node asShape model: each; draggable; yourself ].
    node := RSGroup new.
    node add: (RSEllipse new size: 10; color: Color white; borderColor: Color blue; yourself).
    node translateBy: 0 @ -1; add: (RSLabel new fontSize: 4; text: 'F'; yourself).
    elements add: (node asShape model: false; draggable; yourself).
    node := RSGroup new.
    node add: (RSEllipse new size: 10; color: Color white; borderColor: Color red; yourself).
    node translateBy: 0 @ -1; add: (RSLabel new fontSize: 4; text: 'T'; yourself).
    elements add: (node asShape model: true; draggable; yourself).
    elements := elements as: RSGroup.
    canvas := RSCanvas new addAll: elements; yourself.
    RSLineBuilder line dashed; moveBehind; canvas: canvas; width: 1; color: Color blue;
        connectFromAll: [ :each | nodes select: [ :n | n low == each ] ].
    RSLineBuilder line moveBehind; canvas: canvas; width: 1; color: Color red; connectFromAll: [
            :each | nodes select: [ :n | n high == each ] ].
    RSTreeLayout new on: elements.
    ^ canvas @ RSCanvasController; canvas
]
