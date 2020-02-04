"
See readme on: 
<https://github.com/kasperosterbye/StringSlice>

"
Class {
	#name : #BaselineOfStringUtilities,
	#superclass : #BaselineOf,
	#category : #BaselineOfStringUtilities
}

{ #category : #baselines }
BaselineOfStringUtilities >> baseline: spec [
	<baseline>
	
	spec for: #'common' do: [
		spec 
			package: 'StringUtilities' ]
]
