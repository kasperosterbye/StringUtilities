"
My purpose is to provide an fast way for building strings based on concatenation rather than appending to a stream.

I am really just an OrderedCollection of Strings and StringBuilders (yes, a tree structure).

To get the resulting string, the method #asString does that.

I try to pretend compatible with String, so if you send me one of the string methods, I compute the string I currently represents, and forward the message to that string. To optimize, I compile the forwarding messages under the category 'auto forwarding'

Time millisecondsToRun: [ |s| s := 'aaa'. 1000000 timesRepeat: [ s := s ++ 'bbb' ]. s := s asString ].
Time millisecondsToRun: [ |s| s := 'aaa'. 10000 timesRepeat: [ s := s , 'bbb' ] ]. 
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
	^self new ++ string
]

{ #category : #arithmetic }
StringBuilder >> ++ other [
	"other should be either a string or a ropestring"
	elements addLast: other.
	^self
]

{ #category : #'auto forwarding' }
StringBuilder >> = arg [
	^ self asString = arg
]

{ #category : #converting }
StringBuilder >> asString [
	^ String streamContents: [ :s | self contentsOn:  s ]
]

{ #category : #'auto forwarding' }
StringBuilder >> atAll: atAll [
	^ self asString atAll: atAll
]

{ #category : #'auto forwarding' }
StringBuilder >> beginsWith: beginsWith [
	^ self asString beginsWith: beginsWith
]

{ #category : #converting }
StringBuilder >> contentsOn: aStream [
	elements do: [ :elem | elem contentsOn: aStream ]
]

{ #category : #'auto forwarding' }
StringBuilder >> copyFrom: copyFrom to: to [
	^ self asString copyFrom: copyFrom to: to
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

{ #category : #'auto forwarding' }
StringBuilder >> isString [
	^ self asString isString
]

{ #category : #printing }
StringBuilder >> printOn: aStream [
	aStream nextPut: $'.
	elements do: [ :elem | elem contentsOn: aStream ].
	aStream nextPut: $'
]

{ #category : #'auto forwarding' }
StringBuilder >> printString [
	^ self asString printString
]

{ #category : #accessing }
StringBuilder >> size [
	^ elements inject: 0 into: [ :sofar :elem | sofar + elem size ]
]
