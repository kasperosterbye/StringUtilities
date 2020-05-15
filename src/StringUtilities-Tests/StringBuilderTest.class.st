"
A RopeStringTest is a test class for testing the behavior of RopeString
"
Class {
	#name : #StringBuilderTest,
	#superclass : #TestCase,
	#category : #'StringUtilities-Tests'
}

{ #category : #tests }
StringBuilderTest >> testCR [
	|str|
	str := ( 'aaa' << 'bbb') cr << 'ccc'.
	self assert: str contents equals: 'aaabbb\ccc' withCRs. 
]

{ #category : #tests }
StringBuilderTest >> testNestedBuild [
	| str | 
	str := 'aaa' << ('bbb' << 'ccc') << 'ddd'.
	self assert: str size equals: 12.
	self assert: str contents equals: 'aaabbbcccddd'
]

{ #category : #tests }
StringBuilderTest >> testStringOperationsStillWorks [
	| xxx |
	xxx := ('aaa' << 'bbb') contents.
	
	self assert: (xxx beginsWith: 'aaab').
	self assert: (xxx atAll: (3 to: 5)) equals: 'abb'.
	self assert: ((xxx atAll: (3 to: 5)) << 'ccc') contents equals: 'abbccc'
]

{ #category : #tests }
StringBuilderTest >> testStringToStringBuiderAndBack [
	| x |
	x := ('aaa' << 'bbb') .
	
	self assert: x class equals: StringBuilder.
	self assert: x contents equals: 'aaabbb'.
	self assert: x printString equals: '''aaabbb'''
]
