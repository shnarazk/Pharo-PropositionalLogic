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
DDBuilder class >> app1 [
	"See Figure 7 of Randal E. Bryant, Graph-Based Algorithms for Boolean Function Manipulation,
	IEEE Trans. en Comp., C-35-8, pp.677-691, Aug. 1986."

	^ BDD newFromAssociation: 1 -> {
			  true.
			  (3 -> { true. false }) }
]

{ #category : 'examples' }
DDBuilder class >> app2 [
	"See Figure 7 of Randal E. Bryant, Graph-Based Algorithms for Boolean Function Manipulation,
	IEEE Trans. en Comp., C-35-8, pp.677-691, Aug. 1986."

	^ BDD newFromAssociation: 2 -> {
			  false.
			  (3 -> { false. true }) }
]

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

{ #category : 'examples' }
DDBuilder class >> x1x2_2 [
	"See Figure 7 of Randal E. Bryant, Graph-Based Algorithms for Boolean Function Manipulation,
	IEEE Trans. en Comp., C-35-8, pp.677-691, Aug. 1986."

	^ BDD newFromAssociation: 1 -> {
			  false.
			  (2 -> { false. true }) }
]

{ #category : 'examples' }
DDBuilder class >> x3_2 [
    "See Figure 7 of Randal E. Bryant, Graph-Based Algorithms for Boolean Function Manipulation,
    IEEE Trans. en Comp., C-35-8, pp.677-691, Aug. 1986."

    ^ BDD newFromAssociation: 3 -> { false. true }
]
