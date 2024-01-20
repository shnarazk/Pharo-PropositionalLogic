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
CNFAssignment >> valueFor: anVar [

	^ values at: anVar index
]

{ #category : 'accessing' }
CNFAssignment >> values: aDictionary [

	values := aDictionary
]
