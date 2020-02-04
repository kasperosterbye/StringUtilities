Extension { #name : #String }

{ #category : #'*StringUtilities' }
String >> ++ other [
	"other should be either a string or a ropestring"
	^(StringBuilder on: self) ++ other
]

{ #category : #'*StringUtilities' }
String >> contentsOn: aStream [
	aStream nextPutAll: self
]

{ #category : #'*StringUtilities' }
String >> sliceFrom: a to: b [
	^ StringSlice sliceOf: self from: a to: b
]
