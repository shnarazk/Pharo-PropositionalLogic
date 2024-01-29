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

    ^ DD newFromAssociation: 1 -> {
              true.
              (3 -> { true. false }) }
]

{ #category : 'examples' }
DDBuilder class >> app2 [
    "See Figure 7 of Randal E. Bryant, Graph-Based Algorithms for Boolean Function Manipulation,
    IEEE Trans. en Comp., C-35-8, pp.677-691, Aug. 1986."

    ^ DD newFromAssociation: 2 -> {
              false.
              (3 -> { false. true }) }
]

{ #category : 'examples' }
DDBuilder class >> independent [
    "the independent subsets of Cn correspond to arrangements of 0s and 1s in a circle of
    length n, with no two 1s in a row; the kernels correspond to such arrangements in which
    there also are no three consecutive 0s."

    <todo: 'something is missing'>
    ^ DD newFromAssociation: 1 -> {
              (2 -> {
                   (3 -> {
                        (4 -> {
                             (5 -> {
                                  (6 -> { true. true }).
                                  (6 -> { true. false }) }).
                             (5 -> {
                                  (6 -> { true. true }).
                                  (6 -> { false. false }) }) }).
                        (4 -> {
                             (5 -> {
                                  (6 -> { true. true }).
                                  (6 -> { true. false }) }).
                             (5 -> {
                                  (6 -> { false. false }).
                                  (6 -> { false. false }) }) }) }).
                   (3 -> {
                        (4 -> {
                             (5 -> {
                                  (6 -> { true. true }).
                                  (6 -> { true. false }) }).
                             (5 -> {
                                  (6 -> { false. false }).
                                  (6 -> { false. false }) }) }).
                        (4 -> {
                             (5 -> {
                                  (6 -> { false. false }).
                                  (6 -> { false. false }) }).
                             (5 -> {
                                  (6 -> { false. false }).
                                  (6 -> { false. false }) }) }) }) }).
              (2 -> {
                   (3 -> {
                        (4 -> {
                             (5 -> {
                                  (6 -> { true. true }).
                                  (6 -> { true. false }) }).
                             (5 -> {
                                  (6 -> { true. true }).
                                  (6 -> { false. false }) }) }).
                        (4 -> {
                             (5 -> {
                                  (6 -> { true. true }).
                                  (6 -> { true. false }) }).
                             (5 -> {
                                  (6 -> { false. false }).
                                  (6 -> { false. false }) }) }) }).
                   (3 -> {
                        (4 -> {
                             (5 -> {
                                  (6 -> { false. false }).
                                  (6 -> { false. false }) }).
                             (5 -> {
                                  (6 -> { false. false }).
                                  (6 -> { false. false }) }) }).
                        (4 -> {
                             (5 -> {
                                  (6 -> { false. false }).
                                  (6 -> { false. false }) }).
                             (5 -> {
                                  (6 -> { false. false }).
                                  (6 -> { false. false }) }) }) }) }) }
]

{ #category : 'examples' }
DDBuilder class >> indp [
    "the independent subsets of Cn correspond to arrangements of 0s and 1s in a circle of
    length n, with no two 1s in a row; the kernels correspond to such arrangements in which
    there also are no three consecutive 0s."

    <todo: 'something is missing'>
    ^ DD newFromAssociation: 1 -> {
              (2 -> {
                   (3 -> {
                        (4 -> {
                             (5 -> {
                                  true.
                                  (6 -> { true. false }) }).
                             (5 -> {
                                  (6 -> { true. true }).
                                  false }) }).
                        (4 -> {
                             (5 -> {
                                  true.
                                  (6 -> { true. false }) }).
                             false }) }).
                   (3 -> {
                        (4 -> {
                             (5 -> {
                                  true.
                                  (6 -> { true. false }) }).
                             (5 -> { true. false }) }).
                        false }) }).
              (2 -> {
                   (3 -> {
                        (4 -> {
                             (6 -> { true. false }).
                             (5 -> {
                                  (6 -> { true. false }).
                                  false }) }).
                        (4 -> {
                             (6 -> { true. false }).
                             false }) }).
                   false }) }
]

{ #category : 'examples' }
DDBuilder class >> indpBase [

    ^ DD newFromAssociation: 1 -> {
              (2 -> {
                   (3 -> {
                        (4 -> {
                             (5 -> {
                                  (6 -> { true. true }).
                                  (6 -> { true. true }) }).
                             (5 -> {
                                  (6 -> { true. true }).
                                  (6 -> { true. true }) }) }).
                        (4 -> {
                             (5 -> {
                                  (6 -> { true. true }).
                                  (6 -> { true. true }) }).
                             (5 -> {
                                  (6 -> { true. true }).
                                  (6 -> { true. true }) }) }) }).
                   (3 -> {
                        (4 -> {
                             (5 -> {
                                  (6 -> { true. true }).
                                  (6 -> { true. true }) }).
                             (5 -> {
                                  (6 -> { true. true }).
                                  (6 -> { true. true }) }) }).
                        (4 -> {
                             (5 -> {
                                  (6 -> { true. true }).
                                  (6 -> { true. true }) }).
                             (5 -> {
                                  (6 -> { true. true }).
                                  (6 -> { true. true }) }) }) }) }).
              (2 -> {
                   (3 -> {
                        (4 -> {
                             (5 -> {
                                  (6 -> { true. true }).
                                  (6 -> { true. true }) }).
                             (5 -> {
                                  (6 -> { true. true }).
                                  (6 -> { true. true }) }) }).
                        (4 -> {
                             (5 -> {
                                  (6 -> { true. true }).
                                  (6 -> { true. true }) }).
                             (5 -> {
                                  (6 -> { true. true }).
                                  (6 -> { true. true }) }) }) }).
                   (3 -> {
                        (4 -> {
                             (5 -> {
                                  (6 -> { true. true }).
                                  (6 -> { true. true }) }).
                             (5 -> {
                                  (6 -> { true. true }).
                                  (6 -> { true. true }) }) }).
                        (4 -> {
                             (5 -> {
                                  (6 -> { true. true }).
                                  (6 -> { true. true }) }).
                             (5 -> {
                                  (6 -> { true. true }).
                                  (6 -> { true. true }) }) }) }) }) }
]

{ #category : 'examples' }
DDBuilder class >> majority [
	"See The Art of Computer Programming, Volume 4A, 7.1.4. Binary Decision Diagrams"

	^ DD newFromAssociation: 1 -> {
			  (2 -> {
				   false.
				   (3 -> { false. true }) }).
			  (2 -> {
				   (3 -> { false. true }).
				   true }) }
]

{ #category : 'examples' }
DDBuilder class >> sample0 [

    ^ DD newFromAssociation: 1 -> {
              (2 -> { true. false }).
              (3 -> { false. true }) }
]

{ #category : 'examples' }
DDBuilder class >> sample2 [

    ^ DD newFromAssociation: 1 -> {
              (2 -> { true. false }).
              (3 -> { false. true }) }
]

{ #category : 'examples' }
DDBuilder class >> x1x2 [
	"See Figure 7 of Randal E. Bryant, Graph-Based Algorithms for Boolean Function Manipulation,
	IEEE Trans. en Comp., C-35-8, pp.677-691, Aug. 1986."

	^ DD newFromAssociation: 1 -> {
			  false.
			  (2 -> { false. true }) }
]

{ #category : 'examples' }
DDBuilder class >> x3 [
    "See Figure 7 of Randal E. Bryant, Graph-Based Algorithms for Boolean Function Manipulation,
    IEEE Trans. en Comp., C-35-8, pp.677-691, Aug. 1986."

    ^ DD newFromAssociation: 3 -> { false. true }
]
