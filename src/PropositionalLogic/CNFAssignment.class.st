"
Full/partial assignment from var index to boolean
"
Class {
	#name : 'CNFAssignment',
	#superclass : 'Object',
	#instVars : [
		'values'
	],
	#category : 'PropositionalLogic-Satisfiability',
	#package : 'PropositionalLogic',
	#tag : 'Satisfiability'
}

{ #category : 'instance creation' }
CNFAssignment class >> newFrom: associations [

	^ self new values: associations asDictionary;
		  yourself
]

{ #category : 'evaluating' }
CNFAssignment >> valueOfLiteral: aLiteralInteger [
	"return bool"

	^ aLiteralInteger positive ifTrue: [ values at: aLiteralInteger varIndex ]
		  ifFalse: [ (values at: aLiteralInteger varIndex) not ]
]

{ #category : 'accessing' }
CNFAssignment >> valueOfLiteral: aLiteralInteger put: bool [

	^ values at: aLiteralInteger put: bool
]

{ #category : 'evaluating' }
CNFAssignment >> valueOfVar: aVarIndex [
	"return bool"

	^ values at: aVarIndex
]

{ #category : 'accessing' }
CNFAssignment >> values [

	^ values
]

{ #category : 'accessing' }
CNFAssignment >> values: anObject [

	values := anObject
]
