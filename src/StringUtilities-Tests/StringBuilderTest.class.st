"
A RopeStringTest is a test class for testing the behavior of RopeString
"
Class {
	#name : #StringBuilderTest,
	#superclass : #TestCase,
	#category : #'StringUtilities-Tests'
}

{ #category : #tests }
StringBuilderTest >> testStringOperationsStillWorks [
	| xxx |
	xxx := 'aaa' ++ 'bbb'.
	
	self assert: (xxx beginsWith: 'aaab').
	self assert: (xxx atAll: (3 to: 5)) equals: 'abb'.
	self assert: ((xxx atAll: (3 to: 5)) ++ 'ccc') equals: 'abbccc'
]

{ #category : #tests }
StringBuilderTest >> testStringToStringBuiderAndBack [
	| x |
	x := 'aaa' ++ 'bbb'.
	
	self assert: x class equals: StringBuilder.
	self assert: x asString equals: 'aaabbb'.
	self assert: x printString equals: '''aaabbb'''
]
