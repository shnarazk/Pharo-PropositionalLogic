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
