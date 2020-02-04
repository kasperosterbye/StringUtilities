Class {
	#name : #StringSliceBuilderTest,
	#superclass : #TestCase,
	#category : #'StringUtilities-Tests'
}

{ #category : #tests }
StringSliceBuilderTest >> testBuildFromSlices [
	| build |
	build := ('aaabbbccc' sliceFrom: 4 to: 6) ,+ ('xxxyyyzzz' sliceFrom: 4 to: 6).
	self assert: build equals: 'bbbyyy'
]
