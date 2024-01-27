"
Abstract class for propositional logic satisfiability
"
Class {
	#name : 'CNF',
	#superclass : 'OrderedDictionary',
	#category : 'PropositionalLogic-Satisfiability',
	#package : 'PropositionalLogic',
	#tag : 'Satisfiability'
}

{ #category : 'testing' }
CNF >> isSatisfiedUnder: anAssignment [

	self subclassResponsibility

]
