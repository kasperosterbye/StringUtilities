"
My purpose is to provide an fast way for building strings based on concatenation rather than appending to a stream.

I am really just an OrderedCollection of Strings and StringBuilders (yes, a tree structure).

To get the resulting string, the method #asString does that.

I try to pretend compatible with String, so if you send me one of the string methods, I compute the string I currently represents, and forward the message to that string. To optimize, I compile the forwarding messages under the category 'auto forwarding'.

On my macbook pro StringBuilder is around 100 times faster than concatenation, and around 4 times slower than the stream writing.

Time millisecondsToRun: [ |s| s := 'aaa'. 1000000 timesRepeat: [ s := s ,+ 'bbb' ]. s := s asString ].
Time millisecondsToRun: [ |s| s := 'aaa'. 10000 timesRepeat: [ s := s , 'bbb' ] ].
Time millisecondsToRun: [ String streamContents: [ :s | 1000000 timesRepeat: [ s << 'bbb' ]]].
"
Class {
	#name : #StringBuilder,
	#superclass : #ProtoObject,
	#instVars : [
		'elements'
	],
	#category : #StringUtilities
}

{ #category : #initialization }
StringBuilder class >> initialize [
	self removeProtocol: 'auto forwarding'
]

{ #category : #'instance creation' }
StringBuilder class >> on: string [
	^self new ,+ string
]

{ #category : #arithmetic }
StringBuilder >> ,+ other [
	"other should be either a string or a StringBuilder"
	elements addLast: other.
	^self
]

{ #category : #converting }
StringBuilder >> asString [
	"Make me into a normals string"
	^ String streamContents: [ :s | self stringBuilderContentsOn:  s ]
]

{ #category : #'reflective operations' }
StringBuilder >> doesNotUnderstand: aMessage [
	| methodHeader |
	methodHeader := aMessage selector isUnary
		ifTrue: [ aMessage selector]
		ifFalse: [ aMessage selector isBinary
			ifTrue: [ aMessage selector, ' arg' ]
			ifFalse: [ (aMessage selector keywords 
				collect: [ :kw | kw, ' ', (kw copyUpTo: $:)  ]) joinUsing: ' ' ] ].
	self class 
		compile: methodHeader, String cr, '	^ self asString ', methodHeader 
		classified: 'auto forwarding'.
	^ aMessage sendTo: self asString
]

{ #category : #initialization }
StringBuilder >> initialize [
	elements := OrderedCollection new
]

{ #category : #printing }
StringBuilder >> printOn: aStream [
	aStream nextPut: $'.
	elements do: [ :elem | elem stringBuilderContentsOn: aStream ].
	aStream nextPut: $'
]

{ #category : #accessing }
StringBuilder >> size [
	^ elements inject: 0 into: [ :sofar :elem | sofar + elem size ]
]

{ #category : #converting }
StringBuilder >> stringBuilderContentsOn: aStream [
	elements do: [ :elem | elem stringBuilderContentsOn: aStream ]
]
