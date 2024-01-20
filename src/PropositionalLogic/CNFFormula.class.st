"
I am CNF composed of clauses and methods for roassal.
"
Class {
	#name : 'CNFFormula',
	#superclass : 'CNF',
	#instVars : [
		'clauses'
	],
	#category : 'PropositionalLogic',
	#package : 'PropositionalLogic'
}

{ #category : 'testing' }
CNFFormula >> isSatisfiedUnder: anAssignment [

	^ dictionary allSatisfy: [ :clause | clause isSatisfiedUnder: anAssignment ]
]

{ #category : 'evaluating' }
CNFFormula >> satisfiable [
	"return a satisfiable assignment or nil"

	self notYetImplemented 
]

{ #category : 'testing' }
CNFFormula >> valueUnder: anAssignment [
	"return bool"

	^ self isSatisfiedUnder: anAssignment
]
