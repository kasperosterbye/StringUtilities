"
!! Purpose

I represent a slice/substring of an other string.
My purpose is to prevent excessive coping of substrings. 

I store a reference to the string, and a start and end index.

As a subclass of String, I can do all what strings can do.

- Notice: I am a read only class, and do not allow #at:put: in any of its forms.
- Notice: My species is set to String, to allow the many copying methods of String to build a String rather than a slice.

!!! Notice:
String as a number of methods which should have used ==species== instead of ==class==. I override them here under the category 'ugly species hack'.

Also, class String is (wrongly) assuming there is only two subclasses of String, ByteString and WideString. Some methods is implemented differently for ByteString and for WideString (eg. asUppercase ). Rather than puting the implementation where it belongs, one implementation is in String, and the other overriding in one of the two classes. The right approach whould have been to make an abstract method in String.

Finally, the implementation of ==alike:== in String assumes ==String>>isVariable==, which is not the case (though it is the case for both ByteString and WideString).

"
Class {
	#name : #StringSlice,
	#superclass : #String,
	#instVars : [
		'string',
		'start',
		'end'
	],
	#category : #StringUtilities
}

{ #category : #'instance creation' }
StringSlice class >> new [
	self error: 'Use sliceOf:start:end: to create slices'
]

{ #category : #'instance creation' }
StringSlice class >> sliceOf: string from: start to: end [
	"slices [a:a-1 ] is allowed for empty slice, a in [0:size+1]"
	
	start < 1  ifTrue: [  self errorSubscriptBounds: start  ].
	end > string size ifTrue: [  self errorSubscriptBounds: end  ].
	end + 1  < start ifTrue: [  self errorSubscriptBounds: end  ].
	
	^self basicNew 
		initWith: string
		start: start
		end: end
]

{ #category : #accessing }
StringSlice class >> streamSpecies [ 
	^ String
]

{ #category : #accessing }
StringSlice class >> timing [
	|ipsum |
	ipsum := "'Ç', "(String loremIpsum: 1000).
	^ (0 to: 100 by: 5) collect: [ :n | |stringTime sliceTime |
		Smalltalk garbageCollect.
		stringTime := Time microsecondsToRun: [ 1 to: 10000 do:[:i | ipsum copyFrom: 100 to: 100+n] ].
		Smalltalk garbageCollect.
		sliceTime := Time microsecondsToRun: [ 1 to: 10000 do:[:i | ipsum sliceFrom: 100 to: 100+n] ].
		{ n. stringTime. sliceTime }
	]
	
]

{ #category : #accessing }
StringSlice class >> timingFindTippingPoint [
	"I return the tipping point for when it is more efficient to make a slice of length N than copy N bytes"
	| ipsum index |
	ipsum := String loremIpsum: 2 ** 16 + 1.
	index := {0. 2 ** 15. 2 ** 16}.
	[ index second < index last ]
		whileTrue: [ | times |
			times := [ :n |  | stringTime sliceTime |
				Smalltalk garbageCollect.
				stringTime := Time
					microsecondsToRun: [ 1 to: 10000 do: [ :i | ipsum copyFrom: 100 to: 100 + n ] ].
				Smalltalk garbageCollect.
				sliceTime := Time
					microsecondsToRun: [ 1 to: 10000 do: [ :i | ipsum sliceFrom: 100 to: 100 + n ] ].
			{stringTime. sliceTime} ] value: index second.
			times first < times second
				ifTrue: [ index := {index second.	((index second + index last) // 2). index last} ]
				ifFalse: [ index := {index first.	((index first + index second) // 2).	index second} ] ].
	^ index second
]

{ #category : #'ugly overrides' }
StringSlice >> alike: aString [ 
	"Answer some indication of how alike the receiver is to the argument,  0 is no match, twice aString size is best score (but see example with 7).  Case is ignored. This method is used to help find mistyped variable names in methods."
	"('abc' alike: 'abc') >>> 7."
	"('action' alike: 'actions') >>> 7."
	"('action' alike: 'caption') >>> 5."
	"('action' alike: 'name') >>> 0."	

	| i j k minSize bonus |
	minSize := (j := self size) min: (k := aString size).
	bonus := (j - k) abs < 2 ifTrue: [ 1 ] ifFalse: [ 0 ].
	i := 1.
	[(i <= minSize) and: [((self at: i) asInteger bitAnd: 16rDF)  = ((aString at: i) asciiValue bitAnd: 16rDF)]]
		whileTrue: [ i := i + 1 ].
	[(j > 0) and: [(k > 0) and:
		[((self at: j) asInteger bitAnd: 16rDF) = ((aString at: k) asciiValue bitAnd: 16rDF)]]]
			whileTrue: [ j := j - 1.  k := k - 1. ].
	^ i - 1 + self size - j + bonus
]

{ #category : #'ugly species hack' }
StringSlice >> asCamelCase [
	"Convert to CamelCase, i.e, remove spaces, and convert starting lowercase to uppercase."
   "'A man, a plan, a canal, panama' asCamelCase >>> 'AMan,APlan,ACanal,Panama'"
 	"'Here 123should % be 6 the name6 of the method' asCamelCase  >>> 'Here123should%Be6TheName6OfTheMethod'"
		^ self species streamContents: [:stream |
               self substrings do: [:sub |
                       stream nextPutAll: sub capitalized]]
]

{ #category : #'ugly species hack' }
StringSlice >> asHTMLString [
	"substitute the < & > into HTML compliant elements"
	"'<a>' asHTMLString"
	^ self species new: self size streamContents: [ :s| 
		self do: [:c | s nextPutAll: c asHTMLString ]]

]

{ #category : #'ugly species hack' }
StringSlice >> asHex [
	"'A' asHex >>> '16r41'"
	"'AA' asHex >>> '16r4116r41'"
	^ self species new: self size * 4 streamContents: [ :stream |
		self do: [ :ch | stream nextPutAll: ch hex ]]
]

{ #category : #'ugly overrides' }
StringSlice >> asLowercase [ 
	^self asString asLowercase 
]

{ #category : #copying }
StringSlice >> asString [
	^ string copyFrom: start to: end 
]

{ #category : #'ugly overrides' }
StringSlice >> asUppercase [ 
	^self asString asUppercase 
]

{ #category : #accessing }
StringSlice >> at: localIndex [
	(localIndex between: 1 and: self size) ifFalse: [ self errorSubscriptBounds: localIndex ].
	^ string at: start + localIndex -1
]

{ #category : #accessing }
StringSlice >> at: index put: char [
	"If you end here it could be because a 'self class new' was used instead of 'self species new' "
	self error: 'String slices are read only'
]

{ #category : #'ugly overrides' }
StringSlice >> basicAt: index [
	"I need to overwrite this method as the abstract class String assumes its subclasses to be variable format"
	^ (string at: start+index-1) asInteger 
]

{ #category : #accessing }
StringSlice >> byteAt: index [
	^ string byteAt: index+start-1
]

{ #category : #accessing }
StringSlice >> byteAt: index put: byte [
	"If you end here it could be because a 'self class new' was used instead of 'self species new' "
	self error: 'String slices are read only'
]

{ #category : #accessing }
StringSlice >> byteSize [
	string isWideString 
		ifTrue: [ ^ self size * 4 ]
		ifFalse: [ ^self size ]
]

{ #category : #converting }
StringSlice >> capitalized [
	"Return a copy with the first letter capitalized"
	^self asString capitalized 
]

{ #category : #'ugly species hack' }
StringSlice >> convertFromWithConverter: converter [

	| readStream c |
	readStream := self readStream.
	^ self species new: self size streamContents: [ :writeStream|
		converter ifNil: [^ self].
		[readStream atEnd] whileFalse: [
			c := converter nextFromStream: readStream.
			c
				ifNotNil: [writeStream nextPut: c] 
				ifNil: [^ writeStream contents]]].

]

{ #category : #copying }
StringSlice >> copyFrom: a to: b [
	
	^ self sliceFrom: a to: b
]

{ #category : #'ugly species hack' }
StringSlice >> copyReplaceAll: oldSubstring with: newSubstring [
	"Answer a copy of the receiver in which all occurrences of oldSubstring have been replaced by newSubstring"
	"('ab cd ab ef ab' copyReplaceAll: 'ab' with: 'zk') >>> 'zk cd zk ef zk'"
    | idx |        
    self = oldSubstring ifTrue: [ ^ newSubstring copy ].
    oldSubstring isEmpty ifTrue: [ ^ self copy ].
    idx := 1.
    ^ self species new: self size streamContents: [ :stream | | foundIdx |
        [ (foundIdx := self findString: oldSubstring startingAt: idx) isZero ] whileFalse: [ 
            stream 
                next: (foundIdx - idx) putAll: self startingAt: idx;
                nextPutAll: newSubstring.
            idx := foundIdx + oldSubstring size ].
        idx <= self size ifTrue: [ 
            stream next: (self size - idx + 1) putAll: self startingAt: idx ] ]
]

{ #category : #'ugly species hack' }
StringSlice >> expandMacrosWithArguments: anArray [
	"Interpret the receiver pattern (<1p>, <1s>, <t>...) with argument passed in anArray."
	
	"<Np> writes the N-th argument using #printString, but without trancating it."
	"('<1p>: <2p>' expandMacrosWith: 'Number' with: 5 with: nil) >>> '''Number'': 5'"
	
	"<Ns> writes the N-th argument, which should be a String, or a collection of printable objects.
	Note also important distinction for single-quotes inside the argument; with <p> they will be doubled."
	"('<1s> vs <1p>' expandMacrosWith: 'it''em') >>> 'it''em vs ''it''''em'''"
	
	"Whitespace characters:"
	"'<t>' expandMacros >>> String tab"
	"'<r>' expandMacros >>> String cr"
	"'<n>' expandMacros >>> OSPlatform current lineEnding"
	"'<l>' expandMacros >>> String lf"
	
	"Writing '<' character:
	To write '<', prepend it with a percent sign."
	"'%<n>' expandMacros >>> '<n>'"
	
	"Ternary operator:
	An if-else string can be written with <N?yes-string:no-string>.
	The N-th argument must be a Boolean.
	Yes-string cannot contain colon ':', as it terminates the yes-string.
	No-string cannot contain closing angle bracket '>', as it terminates the no-string."
	"('<1?success:error>' expandMacrosWith: true) >>> 'success'"
	"('<1?success:is error>' expandMacrosWith: false) >>> 'is error'"
	
	| readStream char index |
	^ self species
		new: self size
		streamContents:
			[ :newStream | 
			readStream := self readStream.
			[ readStream atEnd ]
				whileFalse:
					[ char := readStream next.
					char == $<
						ifTrue:
							[ | nextChar |
							nextChar := readStream next asUppercase.
							nextChar == $R
								ifTrue: [ newStream cr ].
							nextChar == $L
								ifTrue: [ newStream lf ].
							nextChar == $T
								ifTrue: [ newStream tab ].
							nextChar == $N
								ifTrue: [ newStream nextPutAll: OSPlatform current lineEnding ].
							nextChar isDigit
								ifTrue:
									[ index := nextChar digitValue.
									[ readStream atEnd or: [ (nextChar := readStream next asUppercase) isDigit not ] ]
										whileFalse: [ index := index * 10 + nextChar digitValue ] ].
							nextChar == $?
								ifTrue:
									[ | trueString falseString |
									trueString := readStream upTo: $:.
									falseString := readStream upTo: $>.
									readStream position: readStream position - 1.
									newStream
										nextPutAll:
											((anArray at: index)
												ifTrue: [ trueString ]
												ifFalse: [ falseString ]) ].
							nextChar == $P
								ifTrue: [ (anArray at: index) printOn: newStream  ].
							nextChar == $S
								ifTrue: [ newStream nextPutAll: (anArray at: index) ].
							readStream skipTo: $> ]
						ifFalse: [ newStream
								nextPut:
									(char == $%
										ifTrue: [ readStream next ]
										ifFalse: [ char ]) ] ] ]
]

{ #category : #'ugly species hack' }
StringSlice >> findSelector [
	"Extract a selector with keyword parts from the receiver. While this doesn't give a true parse, in most cases it does what we want, in where it doesn't, we're none the worse for it."
	
	"'isSymbol' findSelector >>> #isSymbol"
	"'x isSymbol' findSelector >>> nil"
	"'x isSymbol: 33' findSelector >>> #isSymbol:"
	"'between:and:' findSelector >>> #'between:and:'"
	"'2 between: 0 and: 4' findSelector >>> #'between:and:'"
	"'2 between: ( 1 and: 4)' findSelector >>> #between:"
	"'( 1 and: 4)' findSelector >>> nil"
	
	| sel possibleParens |
	sel := self trimBoth.
	sel := sel copyReplaceAll: '#' with: ''.
	sel := sel copyReplaceAll: '[' with: ' [ '.
	(sel includes: $:) ifTrue:
		[sel := sel copyReplaceAll: ':' with: ': '.	"for the style (aa max:bb) with no space"
		possibleParens := sel findTokens: Character separators.
		sel := self species streamContents:
			[:s | | level | level := 0.
			possibleParens do:
				[:token | | n |
				(level = 0 and: [token endsWith: ':'])
					ifTrue: [s nextPutAll: token]
					ifFalse: [(n := token occurrencesOf: $( ) > 0 ifTrue: [level := level + n].
							(n := token occurrencesOf: $[ ) > 0 ifTrue: [level := level + n].
							(n := token occurrencesOf: $] ) > 0 ifTrue: [level := level - n].
							(n := token occurrencesOf: $) ) > 0 ifTrue: [level := level - n]]]]].

	sel isEmpty ifTrue: [^ nil].
	sel isOctetString ifTrue: [sel := sel asOctetString].
	Symbol hasInterned: sel ifTrue:
		[:aSymbol | ^ aSymbol].
	^ nil
]

{ #category : #'ugly species hack' }
StringSlice >> format: collection [
	"Format the receiver by interpolating elements from collection, as in the following examples:" 
	"('Five is {1}.' format: { 1 + 4}) >>> 'Five is 5.'"
	"('Five is {five}.' format: (Dictionary with: #five -> 5)) >>>  'Five is 5.'"
	"('In {1} you can escape \{ by prefixing it with \\' format: {'strings'}) >>> 'In strings you can escape { by prefixing it with \' "
	"('In \{1\} you can escape \{ by prefixing it with \\' format: {'strings'}) >>> 'In {1} you can escape { by prefixing it with \' "

	^ self species
		new: self size
		streamContents: [ :result | 
			| stream |
			stream := self readStream.
			[ stream atEnd ]
				whileFalse: [ | currentChar |
					(currentChar := stream next) == ${
						ifTrue: [ | expression index |
							expression := stream upTo: $}.
							index := Integer readFrom: expression ifFail: [ expression ].
							result nextPutAll: (collection at: index) asString ]
						ifFalse: [ currentChar == $\
								ifTrue: [ stream atEnd
										ifFalse: [ result nextPut: stream next ] ]
								ifFalse: [ result nextPut: currentChar ] ] ] ]
]

{ #category : #accessing }
StringSlice >> fullString [
	^ string
]

{ #category : #'instance creation' }
StringSlice >> initWith: aString start: a end: b [
	string ifNotNil: [ self error: 'already initialized' ].
	string := aString.
	start := a.
	end := b.
]

{ #category : #testing }
StringSlice >> isByteString [
	^string isByteString
]

{ #category : #testing }
StringSlice >> isString [
	^ true
]

{ #category : #testing }
StringSlice >> isWideString [ 
	^string isWideString 
]

{ #category : #'ugly species hack' }
StringSlice >> join: aCollection [
	"Append the elements of the argument, aSequenceableCollection, separating them by the receiver."
	"('*' join: #('WWWWW' 'W  EW' 'zzzz')) >>> 'WWWWW*W  EW*zzzz'"
	
	^ self species new: (aCollection size * self size) streamContents: [:stream | 
			aCollection
				do: [:each | stream nextPutAll: each asString] 
				separatedBy: [stream nextPutAll: self]]
]

{ #category : #'ugly species hack' }
StringSlice >> repeat: aNumber [

	"returns a new string concatenated by itself repeated n times
		'abc' repeat: 3. 'abcabcabc'
	"

	aNumber < 0 ifTrue: [ self error: 'aNumber cannot be negative' ].
	
	^ self species 
		new: self size * aNumber 
		streamContents: [ :stringStream |
			1 to: aNumber do: [ :idx | stringStream nextPutAll: self ].
		]
]

{ #category : #accessing }
StringSlice >> size [
	^ end - start +1
]

{ #category : #copying }
StringSlice >> sliceFrom: a to: b [ 
	(a between: 1 and: self size+1) ifFalse: [ self errorSubscriptBounds: a ].
	(b between: 0 and: self size) ifFalse: [ self errorSubscriptBounds: b ].
	^ self class sliceOf: string from: start+a-1 to: start+b-1
]

{ #category : #'instance creation' }
StringSlice >> species [
	"species are mostly used to create new collections, ie. copy. I am read only, so copy to a new String."
	^String
]

{ #category : #'ugly species hack' }
StringSlice >> surroundedBy: aString [
	"Answer the receiver with leading and trailing aString."
	"('hello' surroundedBy: 'abd') >>> 'abdhelloabd'"
	"('hello' surroundedBy: ' abd ') >>> ' abd hello abd '"
	
	^ self species streamContents: [ :s|
		s nextPutAll: aString.
		s nextPutAll: self.
		s nextPutAll: aString ].
]

{ #category : #'ugly species hack' }
StringSlice >> trimLineSpaces [
	"Trim the spaces from the right side of each line. Useful for code"
	
	^ self species streamContents: [ :str |
		self lines 
			do: [ :line | str nextPutAll: line trimRight]
			separatedBy: [str cr]]
		

]

{ #category : #'ugly species hack' }
StringSlice >> withLineEndings: lineEndingString [
	"Answer a new instance where all occurrences of CRLF, CR, and LF are substituted with the specified line ending string."
	
	^ self species streamContents: [ :out |
		| in c |
		in := self readStream.
		[ in atEnd ] whileFalse: [
			c := in next.
			"CR"
			c == Character cr ifTrue: [
				c := in peek.
				"CR LF"
				c == Character lf ifTrue: [
					in next.
				].
				out nextPutAll: lineEndingString
			] ifFalse: [
				"LF"
				c == Character lf ifTrue: [
					out nextPutAll: lineEndingString
				] ifFalse: [
					out nextPut: c
				]
			]
		]
	]

]

{ #category : #'ugly species hack' }
StringSlice >> withNoLineLongerThan: aNumber [
	"Answer a string with the same content as receiver, but rewrapped so that no line has more characters than the given number"
	(aNumber isNumber not or: [ aNumber < 1 ]) ifTrue: [self error: 'too narrow'].
	^self species
		new: self size * (aNumber + 1) // aNumber "provision for supplementary line breaks"
		streamContents: [ :stream |
			self lineIndicesDo: [ :start :endWithoutDelimiters :end |
				| pastEnd lineStart |
				pastEnd := endWithoutDelimiters + 1.
				"eliminate spaces at beginning of line"
				lineStart := (self indexOfAnyOf: CSNonSeparators startingAt: start ifAbsent: [pastEnd]) min: pastEnd.
				[| lineStop lineEnd spacePosition |
				lineEnd := lineStop  := lineStart + aNumber min: pastEnd.
				spacePosition := lineStart.
				[spacePosition < lineStop] whileTrue: [
					spacePosition := self indexOfAnyOf: CSSeparators startingAt: spacePosition + 1 ifAbsent: [pastEnd].
					spacePosition <= lineStop ifTrue: [lineEnd := spacePosition].
				].
				"split before space or before lineStop if no space"
				stream nextPutAll: (self copyFrom: lineStart to: lineEnd - 1).
				"eliminate spaces at beginning of next line"
				lineStart := self indexOfAnyOf: CSNonSeparators startingAt: lineEnd ifAbsent: [pastEnd].
				lineStart <= endWithoutDelimiters ]
					whileTrue: [stream cr].
				stream nextPutAll: (self copyFrom: pastEnd to: end) ] ]
]

{ #category : #'ugly species hack' }
StringSlice >> withSeparatorsCompacted [
    "Returns a copy of the receiver with each sequence of whitespace (separator) 
    characters replaced by a single space character"
    "' test ' withSeparatorsCompacted >>> ' test '"
    "' test  test' withSeparatorsCompacted >>> ' test test'"
    "'test  test      ' withSeparatorsCompacted >>> 'test test '"

    self isEmpty ifTrue: [ ^ self ].
    ^ self species new: self size streamContents: [:stream | 
        | lastBlank |
        lastBlank := false.
        self do: [ :eachChar | 
            lastBlank 
                ifTrue: [
                    (lastBlank := eachChar isSeparator)
                        ifFalse: [ stream nextPut: eachChar ] ] 
                ifFalse: [
                    (lastBlank := eachChar isSeparator)
                        ifTrue: [ stream nextPut: $  ]
                        ifFalse: [ stream nextPut: eachChar ] ] ] ]
]
