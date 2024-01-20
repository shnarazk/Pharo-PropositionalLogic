"
Full/partial assignment from var index to boolean
"
Class {
	#name : 'CNFAssignment',
	#superclass : 'OrderedDictionary',
	#instVars : [
		'values'
	],
	#category : 'PropositionalLogic',
	#package : 'PropositionalLogic'
}

{ #category : 'as yet unclassified' }
CNFAssignment class >> From: aDictionary [

	^ self new setValues: aDictionary;
		  yourself
]

{ #category : 'as yet unclassified' }
CNFAssignment class >> FromTree: aDictionary [

	^ self new setGraphFromTree: aDictionary;
		  yourself
]

{ #category : 'accessing' }
CNFAssignment >> valueOfLiteral: aLiteral [
	"return bool"

	^ aLiteral positive ifTrue: [ values at: aLiteral varIndex ]
		  ifFalse: [ (values at: aLiteral varIndex) not ]
]

{ #category : 'accessing' }
CNFAssignment >> valueOfVar: aLiteral [
	"return bool"

	^ values at: aLiteral varIndex
]

{ #category : 'accessing' }
CNFAssignment >> values: aDictionary [

	values := aDictionary
]
