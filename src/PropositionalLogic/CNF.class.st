"
Abstract class for propositional logic satisfiability
"
Class {
	#name : 'CNF',
	#superclass : 'OrderedDictionary',
	#category : 'PropositionalLogic',
	#package : 'PropositionalLogic'
}

{ #category : 'testing' }
CNF >> isSatisfiedUnder: anAssignment [

	self subclassResponsibility

]
