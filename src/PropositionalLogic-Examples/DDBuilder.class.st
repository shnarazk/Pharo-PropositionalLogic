"
I am a class to support BDD/ZDD development.
"
Class {
	#name : 'DDBuilder',
	#superclass : 'Object',
	#category : 'PropositionalLogic-Examples',
	#package : 'PropositionalLogic-Examples'
}

{ #category : 'examples' }
DDBuilder class >> majority0 [
	"See The Art of Computer Programming, Volume 4A, 7.1.4. Binary Decision Diagrams"

	^ ZDD newFromAssociation: 1 -> {
			  (2 -> {
				   false.
				   (3 -> { false. true }) }).
			  (2 -> {
				   (3 -> { false. true }).
				   true }) }
]

{ #category : 'examples' }
DDBuilder class >> majority2 [
	"See The Art of Computer Programming, Volume 4A, 7.1.4. Binary Decision Diagrams"

	^ BDD newFromAssociation: 1 -> {
			  (2 -> {
				   false.
				   (3 -> { false. true }) }).
			  (2 -> {
				   (3 -> { false. true }).
				   true }) }
]

{ #category : 'examples' }
DDBuilder class >> sample0 [

	^ ZDD newFromAssociation: 1 -> {
			  (2 -> { true. false }).
			  (3 -> { false. true }) }
]

{ #category : 'examples' }
DDBuilder class >> sample2 [

	^ BDD newFromAssociation: 1 -> {
			  (2 -> { true. false }).
			  (3 -> { false. true }) }
]
