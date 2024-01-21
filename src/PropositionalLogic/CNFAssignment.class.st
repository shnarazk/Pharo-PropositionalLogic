"
Full/partial assignment from var index to boolean
"
Class {
	#name : 'CNFAssignment',
	#superclass : 'Object',
	#instVars : [
		'values'
	],
	#category : 'PropositionalLogic',
	#package : 'PropositionalLogic'
}

{ #category : 'instance creation' }
CNFAssignment class >> From: aDictionary [

	^ self new values: aDictionary;
		  yourself
]

{ #category : 'accessing' }
CNFAssignment >> valueOfLiteral: aLiteralInteger [
	"return bool"

	^ aLiteralInteger positive ifTrue: [ values at: aLiteralInteger varIndex ]
		  ifFalse: [ (values at: aLiteralInteger varIndex) not ]
]

{ #category : 'accessing' }
CNFAssignment >> valueOfLiteral: aLiteralInteger put: bool [

	^ values at: aLiteralInteger put: bool
]

{ #category : 'accessing' }
CNFAssignment >> valueOfVar: aVarIndex [
	"return bool"

	^ values at: aVarIndex
]
