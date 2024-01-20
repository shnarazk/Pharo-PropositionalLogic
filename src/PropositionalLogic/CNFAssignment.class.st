Class {
	#name : 'CNFAssignment',
	#superclass : 'OrderedDictionary',
	#instVars : [
		'values'
	],
	#category : 'PropositionalLogic',
	#package : 'PropositionalLogic'
}

{ #category : 'accessing' }
CNFAssignment >> valueFor: anVar [

	^ values at: anVar index
]
