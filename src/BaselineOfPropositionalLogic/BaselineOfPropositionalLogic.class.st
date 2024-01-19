Class {
	#name : 'BaselineOfPropositionalLogic',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfPropositionalLogic',
	#package : 'BaselineOfPropositionalLogic'
}

{ #category : 'baselines' }
BaselineOfPropositionalLogic >> baseline: spec [

	<baseline>
	spec for: #common do: [ spec package: 'PropositionalLogic' ].
	spec for: #common do: [ spec package: 'PropositionalLogic-Test' ]
]
