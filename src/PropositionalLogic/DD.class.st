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
	#category : 'PropositionalLogic-DecisionDiagram',
	#package : 'PropositionalLogic',
	#tag : 'DecisionDiagram'
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

{ #category : 'composing' }
DD >> and: other [

    ^ self apply: [ :a :b | a & b ] unit: false with: other
]

{ #category : 'algorithm - private' }
DD >> apply: operator on: aGraph and: otherGraph using: aTable [

    self subclassResponsibility
]

{ #category : 'algorithm' }
DD >> apply: anOperator unit: aBool with: other [

    | aDict otherGraph |
    "Contract: embed anOperator at -1, aBool at 0, false at 1 and true at 2"
    aDict := Dictionary new at: 0 put: aBool; at: false put: false; at: true put: true; yourself.
    otherGraph := other graph reindexedClone: graph allNodesSet size + 1; yourself.
    graph := self apply: anOperator
                 on: graph
                 and: otherGraph
                 using: aDict.
    ^ self "reduce"
]

{ #category : 'algorithm' }
DD >> compose: anVarIndex as: other [
    "f_1|_{x_i=f_2}"

   self composeGraph: graph and: other graph at: anVarIndex 
]

{ #category : 'as yet unclassified' }
DD >> composeGraph: aGraph and: otherGraph at: anVarIndex [

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

{ #category : 'composing' }
DD >> or: other [

	^ self apply: [ :a :b | a | b ] unit: true with: other
]

{ #category : 'algorithm' }
DD >> reduce [
    "reduce to canonical form"

    self reduce: graph
]

{ #category : 'algorithm - private' }
DD >> reduce: aGraph [
    "reduce to canonical form"

    self subclassResponsibility
]

{ #category : 'algorithm' }
DD >> restrict: aVarIndex to: aBool [
    "f|_{x_i=b}"

    graph allNodesSet do: [ :node |
        node varIndex = aVarIndex ifTrue: [
            aBool ifFalse: [ node low: false ] ifTrue: [ node high: true ] ] ].
    self reduce
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
                            (RSLabel new fontSize: 4; text: each varIndex; yourself).
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
