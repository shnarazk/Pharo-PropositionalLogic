"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : 'ManifestPropositionalLogic',
	#superclass : 'PackageManifest',
	#category : 'PropositionalLogic-Manifest',
	#package : 'PropositionalLogic',
	#tag : 'Manifest'
}

{ #category : 'code-critics' }
ManifestPropositionalLogic class >> ruleExcessiveArgumentsRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGPackageDefinition #(#PropositionalLogic)) #'2024-01-28T20:22:56.149821+09:00') )
]

{ #category : 'code-critics' }
ManifestPropositionalLogic class >> ruleLongMethodsRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGPackageDefinition #(#PropositionalLogic)) #'2024-01-27T12:30:48.600635+09:00') )
]
