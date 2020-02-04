"
A StringSliceTest is a test class for testing the behavior of StringSlice
"
Class {
	#name : #StringSliceTest,
	#superclass : #TestCase,
	#category : #'StringUtilities-Tests'
}

{ #category : #'helper methods' }
StringSliceTest >> sliceFor: aString [
	^ StringSlice sliceOf: ('ww',aString,'qq') from: 3 to: aString size + 2
]

{ #category : #tests }
StringSliceTest >> testActualSlice [
	self assert: (StringSlice sliceOf: 'abcd' from: 1 to: 1 ) equals: 'a'.
	self assert: (StringSlice sliceOf: 'abcd' from: 1 to: 3 ) equals: 'abc'.
	self assert: (StringSlice sliceOf: 'abcd' from: 2 to: 3 ) equals: 'bc'.
	self assert: (StringSlice sliceOf: 'abcd' from: 2 to: 4 ) equals: 'bcd'.
]

{ #category : #tests }
StringSliceTest >> testAlike [
	"test alike with slice as first, second and both arguments"

	self assert: ((self sliceFor: 'test') alike: 'test') >= 8. 
	self assert: ('TEST' alike: (self sliceFor: 'test')) >= 8. 
	self assert: ((self sliceFor: 'eeeee') alike: (self sliceFor: 'ééééé')) <= 1 
]

{ #category : #tests }
StringSliceTest >> testCopyFromTo [
   self assert: ((StringSlice sliceOf: 'abcdef' from: 2 to: 4 ) copyFrom: 2 to: 3) equals: 'cd'.
	self assert: ((StringSlice sliceOf: 'abcdef' from: 2 to: 4 ) copyFrom: 3 to: 2) equals: ''.
	self assert: ((StringSlice sliceOf: 'abcdef' from: 2 to: 4 ) copyFrom: 1 to: 0) equals: ''.
	self assert: ((StringSlice sliceOf: 'abcdef' from: 2 to: 4 ) copyFrom: 3 to: 2) equals: ''.
	self assert: ((StringSlice sliceOf: 'abcdef' from: 2 to: 4 ) copyFrom: 1 to: 3) equals: 'bcd'.
	
	self should: [(StringSlice sliceOf: 'abcdef' from: 2 to: 4 ) copyFrom: 0 to: 1] raise: SubscriptOutOfBounds .
	self should: [(StringSlice sliceOf: 'abcdef' from: 2 to: 4 ) copyFrom: 3 to: 1] raise: SubscriptOutOfBounds.
	self should: [(StringSlice sliceOf: 'abcdef' from: 2 to: 4 ) copyFrom: 4 to: 2] raise: SubscriptOutOfBounds.
]

{ #category : #tests }
StringSliceTest >> testEmptySlice [
	self assert: (StringSlice sliceOf: '' from: 1 to: 0) equals: ''.
	self assert: (StringSlice sliceOf: 'aaa' from: 1 to: 0) equals: ''.
	self assert: (StringSlice sliceOf: 'aaa' from: 2 to: 1) equals: ''.
	self assert: (StringSlice sliceOf: 'aaa' from: 4 to: 3) equals: ''.
]

{ #category : #tests }
StringSliceTest >> testIllegalSlices [
	self should: [ StringSlice sliceOf: 'aaa' from: -2 to: 2 ] raise: SubscriptOutOfBounds.
	self should: [ StringSlice sliceOf: 'aaa' from: 0 to: 2 ] raise: SubscriptOutOfBounds.
	self should: [ StringSlice sliceOf: 'aaa' from: 1 to: 4 ] raise: SubscriptOutOfBounds.
	self should: [ StringSlice sliceOf: 'aaa' from: 3 to: 5 ] raise: SubscriptOutOfBounds.
	self should: [ StringSlice sliceOf: 'aaa' from: 2 to: 12 ] raise: SubscriptOutOfBounds.
]

{ #category : #tests }
StringSliceTest >> testMisc [
	self assert: (StringSlice sliceOf: 'abcd' from: 2 to: 3 ) fullString equals: 'abcd'.
	self assert: (StringSlice sliceOf: 'abcd' from: 2 to: 3 ) asString equals: 'bc'.
	
	self assert: (StringSlice sliceOf: 'abcd' from: 2 to: 3 ) species equals: String.
	self assert: (StringSlice sliceOf: 'abcd' from: 2 to: 3 ) isString.
	
	self assert: ((StringSlice sliceOf: 'abcd' from: 2 to: 3 ) basicAt: 1) equals: $b asInteger
]

{ #category : #tests }
StringSliceTest >> testSize [
	self assert: (StringSlice sliceOf: 'aaa' from: 1 to: 3 ) size equals: 3.
	self assert: (StringSlice sliceOf: 'aaa' from: 1 to: 0 ) size equals: 0.
	self assert: (StringSlice sliceOf: 'aaa' from: 4 to: 3 ) size equals: 0.
	self assert: (StringSlice sliceOf: 'aaa' from: 1 to: 2 ) size equals: 2.
	
]

{ #category : #tests }
StringSliceTest >> testWideAndByteStrings [
	"$∆ is a wide char"
	self assert: (StringSlice sliceOf: '∆∆∆' from: 1 to: 3 ) equals: '∆∆∆'.
	self assert: (StringSlice sliceOf: '∆∆∆' from: 1 to: 3 ) isWideString.
	self assert: (StringSlice sliceOf: '∆∆∆' from: 1 to: 3 ) isByteString not.
	self assert: (StringSlice sliceOf: 'aaa' from: 1 to: 3 ) isWideString not.
	self assert: (StringSlice sliceOf: 'aaa' from: 1 to: 3 ) isByteString .
]
