Extension { #name : #String }

{ #category : #'*StringUtilities' }
String >> ,+ other [
	"other should be either a string or a StringBuilder"
	^(StringBuilder on: self) ,+ other
]

{ #category : #'*StringUtilities' }
String >> sliceFrom: a to: b [
	^ StringSlice sliceOf: self from: a to: b
]

{ #category : #'*StringUtilities' }
String >> stringBuilderContentsOn: aStream [
	aStream nextPutAll: self
]
