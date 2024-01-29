"
Abstract class for propositional logic satisfiability
"
Class {
	#name : 'CNF',
	#superclass : 'Object',
	#category : 'PropositionalLogic-Satisfiability',
	#package : 'PropositionalLogic',
	#tag : 'Satisfiability'
}

{ #category : 'instance creation' }
CNF class >> newFromStream: aStream [

    self subclassResponsibility
]

{ #category : 'testing' }
CNF >> isSatisfiedUnder: anAssignment [

	self subclassResponsibility

]
