Class {
	#name : #StringSliceAsStringTest,
	#superclass : #CollectionRootTest,
	#traits : 'TIncludesTest + TCloneTest + TCopyTest + TSetArithmetic + TIterateSequencedReadableTest + TPrintOnSequencedTest + TAsStringCommaAndDelimiterSequenceableTest + TIndexAccess + TSequencedElementAccessTest + TSubCollectionAccess + TCopySequenceableSameContents + TCopyPartOfSequenceable + TCopyPartOfSequenceableForMultipliness + TCopySequenceableWithOrWithoutSpecificElements + TCopySequenceableWithReplacement + (TConvertTest - {#testAsByteArray}) + TConvertAsSortedTest + TBeginsEndsWith + (TIndexAccessForMultipliness - {#testIdentityIndexOfIAbsentDuplicate. #testIdentityIndexOfDuplicate. #collectionWithNonIdentitySameAtEndAndBegining}) + TSequencedConcatenationTest + TConvertAsSetForMultiplinessTest + TSequencedStructuralEqualityTest + TOccurrencesForMultiplinessTest + TCreationWithTest',
	#classTraits : 'TIncludesTest classTrait + TCloneTest classTrait + TCopyTest classTrait + TSetArithmetic classTrait + TIterateSequencedReadableTest classTrait + TPrintOnSequencedTest classTrait + TAsStringCommaAndDelimiterSequenceableTest classTrait + TIndexAccess classTrait + TSequencedElementAccessTest classTrait + TSubCollectionAccess classTrait + TCopySequenceableSameContents classTrait + TCopyPartOfSequenceable classTrait + TCopyPartOfSequenceableForMultipliness classTrait + TCopySequenceableWithOrWithoutSpecificElements classTrait + TCopySequenceableWithReplacement classTrait + TConvertTest classTrait + TConvertAsSortedTest classTrait + TBeginsEndsWith classTrait + TIndexAccessForMultipliness classTrait + TSequencedConcatenationTest classTrait + TConvertAsSetForMultiplinessTest classTrait + TSequencedStructuralEqualityTest classTrait + TOccurrencesForMultiplinessTest classTrait + TCreationWithTest classTrait',
	#instVars : [
		'string',
		'emptyString',
		'elementInNonEmpty',
		'notIn',
		'nonEmpty1element',
		'withoutEqualElements',
		'collectionNotIncluded',
		'indexInNonEmptyArray',
		'sameAtEndAndBegining',
		'nonEmpty5ElementsSorted',
		'unsortedCollection',
		'subcollection3ElementsSorted',
		'arrayWithCharacters'
	],
	#category : #'StringUtilities-Tests'
}

{ #category : #requirements }
StringSliceAsStringTest >> aValue [
	"Return a value to put into nonEmpty"
	
	^ elementInNonEmpty 
]

{ #category : #requirements }
StringSliceAsStringTest >> anIndex [
	"Return an index in nonEmpty bounds"
	
	^ 2
]

{ #category : #'tests - includes' }
StringSliceAsStringTest >> anotherElementNotIn [
	^ $k
]

{ #category : #requirements }
StringSliceAsStringTest >> anotherElementOrAssociationIn [
	" return an element (or an association for Dictionary ) present  in 'collection' "
	^ self collection  anyOne
]

{ #category : #requirements }
StringSliceAsStringTest >> anotherElementOrAssociationNotIn [
	" return an element (or an association for Dictionary )not present  in 'collection' "
	^ notIn 
]

{ #category : #requirements }
StringSliceAsStringTest >> anotherValue [
	"Return a value (not equal to 'aValue') to put into nonEmpty"
	
	^ self nonEmpty anyOne
]

{ #category : #coverage }
StringSliceAsStringTest >> classToBeTested [
	^ StringSlice
]

{ #category : #'tests - includes' }
StringSliceAsStringTest >> collection [
	^ self sliceFor: 'ghj'
]

{ #category : #'tests - set arithmetic' }
StringSliceAsStringTest >> collectionClass [
	"Return the class to be used to create instances of the class tested"
	"Actually, the about is not true - I return instances used as arguments to the class to be tested"
	^ String
]

{ #category : #requirements }
StringSliceAsStringTest >> collectionMoreThan1NoDuplicates [
	" return a collection of size > 1 without equal elements"
	^ withoutEqualElements 
]

{ #category : #requirements }
StringSliceAsStringTest >> collectionMoreThan5Elements [
" return a collection including at least 5 elements"
	
	^ nonEmpty5ElementsSorted 
]

{ #category : #requirements }
StringSliceAsStringTest >> collectionNotIncluded [
	"Return a collection for wich each element is not included in 'nonEmpty'"

	^ collectionNotIncluded  
]

{ #category : #requirements }
StringSliceAsStringTest >> collectionWith1TimeSubcollection [
	"Return a collection including 'oldSubCollection' only one time"
	
	^ nonEmpty5ElementsSorted
]

{ #category : #requirements }
StringSliceAsStringTest >> collectionWith2TimeSubcollection [
	"Return a collection including 'oldSubCollection' two or many time"
	
	^ nonEmpty5ElementsSorted, subcollection3ElementsSorted 
]

{ #category : #requirements }
StringSliceAsStringTest >> collectionWithElement [
	"Returns a collection that already includes what is returned by #element."
	^ nonEmpty5ElementsSorted
]

{ #category : #requirements }
StringSliceAsStringTest >> collectionWithElementsToRemove [
	"Return a collection of elements included in 'nonEmpty'"

	^ subcollection3ElementsSorted 
]

{ #category : #requirements }
StringSliceAsStringTest >> collectionWithEqualElements [
	"Return a collecition including atLeast two elements equal"

	^ sameAtEndAndBegining 
]

{ #category : #requirements }
StringSliceAsStringTest >> collectionWithSameAtEndAndBegining [
	"Return a collection with elements at end and begining equals
	 (other elements of the collection are not equal to those elements)"

	^ sameAtEndAndBegining 
]

{ #category : #requirements }
StringSliceAsStringTest >> collectionWithSortableElements [
	"Return a collection only including elements that can be sorted (understanding '<')"

	^ nonEmpty5ElementsSorted
]

{ #category : #requirements }
StringSliceAsStringTest >> collectionWithoutEqualElements [
	"Return a collection not including equal elements"
	
	^ withoutEqualElements 
]

{ #category : #requirements }
StringSliceAsStringTest >> collectionWithoutNilElements [
	"Return a collection that doesn't include a nil element and that doesn't include equal elements'"

	^ nonEmpty5ElementsSorted
]

{ #category : #requirements }
StringSliceAsStringTest >> element [
	"Returns an object that can be added to the collection returned by #collection."
	
	^ elementInNonEmpty 
]

{ #category : #requirements }
StringSliceAsStringTest >> elementInForElementAccessing [
	"Return an element included in 'moreThan4Elements'"
	
	^ self moreThan4Elements anyOne
]

{ #category : #requirements }
StringSliceAsStringTest >> elementInForIncludesTest [
	"Return an element included in nonEmpty"
	
	^ elementInNonEmpty 
]

{ #category : #requirements }
StringSliceAsStringTest >> elementInForIndexAccessing [
" return an element included in 'accessCollection' "
	^ withoutEqualElements anyOne
]

{ #category : #requirements }
StringSliceAsStringTest >> elementNotIn [
	"Return an element not included in 'nonEmpty'"

	^notIn 
]

{ #category : #requirements }
StringSliceAsStringTest >> elementNotInForElementAccessing [
	"Return an element not included in 'moreThan4Elements'"

	^ notIn 
]

{ #category : #requirements }
StringSliceAsStringTest >> elementNotInForIndexAccessing [
	"Return an element not included in 'accessCollection'"
	
	^ notIn 
]

{ #category : #'tests - includes' }
StringSliceAsStringTest >> elementNotInForOccurrences [
	^ $z
]

{ #category : #'tests - copy' }
StringSliceAsStringTest >> elementToAdd [
	^ $u
]

{ #category : #requirements }
StringSliceAsStringTest >> elementTwiceInForOccurrences [
" return an element included exactly two time in # collectionWithEqualElements"
^ sameAtEndAndBegining first .
]

{ #category : #requirements }
StringSliceAsStringTest >> empty [
	^ emptyString
]

{ #category : #'tests - indexof' }
StringSliceAsStringTest >> findFirstInString: aString fromString: searchString [

	^ String findFirstInString: aString inSet: (CharacterSet newFrom: searchString) byteArrayMap startingAt: 1
]

{ #category : #requirements }
StringSliceAsStringTest >> firstCollection [
	"Return a collection that will be the first part of the concatenation"
	
	^ nonEmpty5ElementsSorted
]

{ #category : #requirements }
StringSliceAsStringTest >> firstIndex [
	"Return an index between 'nonEmpty' bounds that is < to 'second index'"

	^3
]

{ #category : #requirements }
StringSliceAsStringTest >> indexArray [
	"Return a Collection including indexes between bounds of 'nonEmpty'"

	^ indexInNonEmptyArray 
]

{ #category : #requirements }
StringSliceAsStringTest >> indexInForCollectionWithoutDuplicates [
	"Return an index between 'collectionWithoutEqualsElements' bounds"
	
	^ 2
]

{ #category : #requirements }
StringSliceAsStringTest >> indexInNonEmpty [
	"Return an index between bounds of 'nonEmpty'"

	^ 2
]

{ #category : #requirements }
StringSliceAsStringTest >> integerCollectionWithoutEqualElements [
	"Return a collection of integer without equal elements"	
		
	^ nonEmpty5ElementsSorted
]

{ #category : #requirements }
StringSliceAsStringTest >> moreThan3Elements [
	"Return a collection including at least 3 elements"
	
	^ nonEmpty5ElementsSorted
]

{ #category : #requirements }
StringSliceAsStringTest >> moreThan4Elements [
	"Return a collection including at least 4 elements"

	^ nonEmpty5ElementsSorted
]

{ #category : #requirements }
StringSliceAsStringTest >> newElement [
	"Return an element that will be put in the collection in place of another"
	
	^ elementInNonEmpty 
]

{ #category : #requirements }
StringSliceAsStringTest >> nonEmpty [
	^ nonEmpty5ElementsSorted
]

{ #category : #requirements }
StringSliceAsStringTest >> nonEmpty1Element [
	"Return a collection of size 1 including one element"
	
	^ nonEmpty1element 
]

{ #category : #requirements }
StringSliceAsStringTest >> nonEmptyMoreThan1Element [
	"Return a collection that don't includes equal elements'"
	
	^ nonEmpty5ElementsSorted
]

{ #category : #requirements }
StringSliceAsStringTest >> oldSubCollection [
	"Return a subCollection included in collectionWith1TimeSubcollection.
		Example:  subCollection := #( 2 3 4) and collectionWith1TimeSubcollection := #(1 2 3 4 5)"
		
	^ subcollection3ElementsSorted  
]

{ #category : #requirements }
StringSliceAsStringTest >> otherCollection [
	"Returns a collection that does not include what is returned by #element."
	
	^ collectionNotIncluded 
]

{ #category : #requirements }
StringSliceAsStringTest >> replacementCollection [
	"Return a collection that will be used to replace 'oldSubcollection' in ' 	 collectionWith1TimeSubcollection'" 
	^ string
]

{ #category : #requirements }
StringSliceAsStringTest >> replacementCollectionSameSize [
	"Return a collection of size (secondIndex - firstIndex + 1)"
	
	^nonEmpty1element 
]

{ #category : #requirements }
StringSliceAsStringTest >> secondCollection [
	"Return a collection that will be the second part of the concatenation"
	
	^ nonEmpty1element 
]

{ #category : #requirements }
StringSliceAsStringTest >> secondIndex [
	"Return an index between 'nonEmpty' bounds that is > to 'second index'"
	
	^ self firstIndex 
]

{ #category : #running }
StringSliceAsStringTest >> setUp [
	<compilerOptions: #(- #optionReadOnlyLiterals)>
	super setUp.
	string := self sliceFor: 'Hi, I am a String'.
	emptyString := self sliceFor: ''.
	subcollection3ElementsSorted := self sliceFor: 'bcd'.
	nonEmpty5ElementsSorted := self sliceFor: ('a' , subcollection3ElementsSorted , 'e').
	unsortedCollection := self sliceFor: 'azsbe'.
	indexInNonEmptyArray := #(1 3 2 ).
	arrayWithCharacters := #($a $b $c ).
	nonEmpty1element := self sliceFor: 'a'.
	withoutEqualElements := self sliceFor: 'abcde'.
	
	sameAtEndAndBegining := self sliceFor: 'abca'.
	elementInNonEmpty := $c.
	notIn := $z.
	collectionNotIncluded := self sliceFor: (notIn asString , notIn asString).
]

{ #category : #requirements }
StringSliceAsStringTest >> sizeCollection [
	"Answers a collection whose #size is 4"
	^ self sliceFor: 'abcd'
]

{ #category : #'helper methods' }
StringSliceAsStringTest >> sliceFor: aString [
	^ StringSlice sliceOf: ('ww',aString,'qq') from: 3 to: aString size + 2
]

{ #category : #requirements }
StringSliceAsStringTest >> sortedInAscendingOrderCollection [
" return a collection sorted in an acsending order"
	^nonEmpty5ElementsSorted 
	
]

{ #category : #requirements }
StringSliceAsStringTest >> subCollectionNotIn [
	"Return a collection for which at least one element is not included in 'moreThan4Elements'"
	
	^ collectionNotIncluded 
]

{ #category : #tests }
StringSliceAsStringTest >> testAlike [

	self assert: ((self sliceFor:'test') alike: 'test') >= 8.   "twice second argument size is the best score"
	self assert: ((self sliceFor:'TEST') alike: 'test') >= 8.   "case is ignored"
	self assert: ((self sliceFor:'é è à ô ü ö ß ä ó ñ í á') alike: 'test') equals: 0. 
	self assert: ((self sliceFor:'é è à ô ü ö') alike: 'é è à ô ü ö ß ä ó ñ í á') >= 10. 
	self assert: ((self sliceFor:'eeeee') alike: 'ééééé') <= 1.  "evaluation based on ascii value"
	
	self assert: ('test' alike: (self sliceFor: 'test'))  >= 8.   "twice second argument size is the best score"
	self assert: ((self sliceFor:'TEST') alike: (self sliceFor:'test')) >= 8.   "case is ignored"
]

{ #category : #tests }
StringSliceAsStringTest >> testAllRangesOfSubstring [

	self assert: ((self sliceFor: 'aabbccbb') allRangesOfSubstring: 'bb' ) equals: {(3 to: 4). (7 to: 8)}.
	self assert: ((self sliceFor: 'é è à ô ü ö ß ä ó ñ í á') allRangesOfSubstring: 'ö ß ä') equals: {(11 to: 15)}.
	self assert: ((self sliceFor: 'test') allRangesOfSubstring: '') equals: #()
]

{ #category : #'tests - converting' }
StringSliceAsStringTest >> testAsCamelCase [

	self assert: (self sliceFor:'A man, a plan, a canal, panama') asCamelCase equals: 'AMan,APlan,ACanal,Panama'.
	self assert: (self sliceFor:'Here 123should % be 6 the name6 of the method') asCamelCase equals: 'Here123should%Be6TheName6OfTheMethod'.
 
]

{ #category : #tests }
StringSliceAsStringTest >> testAsDate [

	self assert: (self sliceFor: 'Jan 1 2015') asDate asString equals: '1 January 2015'. 
]

{ #category : #tests }
StringSliceAsStringTest >> testAsHTMLString [

	self assert: (self sliceFor: '<a>') asHTMLString equals: '&lt;a&gt;'.
	self assert: (self sliceFor: '<!DOCTYPE html>') asHTMLString equals: '&lt;!DOCTYPE html&gt;'. 
	self assert: (self sliceFor: 'é è à ô ü ö ß ä ó ñ í á') asHTMLString equals: 'é è à ô ü ö ß ä ó ñ í á'.
	self assert: (self sliceFor: '') asHTMLString equals: ''
]

{ #category : #'tests - converting' }
StringSliceAsStringTest >> testAsInteger [

	self assert: (self sliceFor:'1796exportFixes-tkMX') asInteger equals: 1796.
]

{ #category : #tests }
StringSliceAsStringTest >> testAsLowercase [ 

	self assert: (self sliceFor: '1 2 3 É È À Ô Ü Ö ẞ t e s T Ć') asLowercase equals: '1 2 3 é è à ô ü ö ß t e s t ć'.
	self assert: (self sliceFor: '!@#$') asLowercase equals: '!@#$'.
	self assert: (self sliceFor: '') asLowercase equals: ''
]

{ #category : #tests }
StringSliceAsStringTest >> testAsPluralBasedOn [

	self assert: ((self sliceFor: 'test') asPluralBasedOn: #(1)) equals: 'test'.
	self assert: ((self sliceFor: 'test') asPluralBasedOn: #(1 2 3)) equals: 'tests'.
	self assert: ((self sliceFor: 'test') asPluralBasedOn: 1) equals: 'test'.
	self assert: ((self sliceFor: 'test') asPluralBasedOn: false) equals: 'tests'.
	self assert: ((self sliceFor: 'é è à ô ü ö ß ä ó ñ í á') asPluralBasedOn: 10) equals: 'é è à ô ü ö ß ä ó ñ í ás'.
	self assert: ((self sliceFor: '') asPluralBasedOn: 1) equals: ''.
	self assert: ((self sliceFor: '%') asPluralBasedOn: 10) equals: '%s'
]

{ #category : #tests }
StringSliceAsStringTest >> testAsSignedInteger [

	self assert: (self sliceFor: 'test') asSignedInteger isNil.
	self assert: (self sliceFor: 'é è à ô ü ö ß ä ó ñ í á') asSignedInteger isNil.
	self assert: (self sliceFor: 'test-10test') asSignedInteger equals: -10.
	self assert: ((self sliceFor: '') asSignedInteger) equals: nil.
	self assert: (self sliceFor: '1234567890-1234567890') asSignedInteger equals: 1234567890.
	self assert: (self sliceFor: '--12345') asSignedInteger equals: -12345
]

{ #category : #'tests - converting' }
StringSliceAsStringTest >> testAsSmalltalkComment [
	| exampleStrings |
	exampleStrings := #('' ' ' '"' '""' '"""' 'abc"abc' 'abc""abc' 'abc"hello"abc' 'abc"' '"abc') collect: [:s| self sliceFor: s].

	"check that the result of scanning the comment is empty"
	exampleStrings
		do: [ :s | 
			| tokens |
			tokens := s asComment parseLiterals.
			self assertEmpty: tokens ].

	"check that the result has the same non-quote characters as the original"
	exampleStrings do: [ :s | self assert: (s copyWithout: $") equals: (s asComment copyWithout: $") ].

	"finnaly, test for some common kinds of inputs"
	self assert: (self sliceFor:'abc') asComment equals: '"abc"'.
]

{ #category : #tests }
StringSliceAsStringTest >> testAsSymbol [
	self assert: (self sliceFor: 'hel' , 'lo') asSymbol equals: #hello.
	self assert: (self sliceFor: '') asSymbol equals: #''.
]

{ #category : #tests }
StringSliceAsStringTest >> testAsTime [ 

	self assert: (self sliceFor: '1:00:00') asTime asString equals: '1:00 am'.

]

{ #category : #tests }
StringSliceAsStringTest >> testAsUppercase [ 

	self assert: (self sliceFor: 'éèàôütestẞć') asUppercase equals: 'ÉÈÀÔÜTESTẞĆ'.
	self assert: (self sliceFor: '123éàôüößTEST') asUppercase equals: '123ÉÀÔÜÖẞTEST'.
	self assert: (self sliceFor: '') asUppercase equals: ''
]

{ #category : #'tests - accessing' }
StringSliceAsStringTest >> testAt [
	self assert: (string at: 1) equals: $H.
]

{ #category : #tests }
StringSliceAsStringTest >> testBeginsWithEmptyCaseSensitive [

	self deny: ( (self sliceFor:'éèàôüößäóñíá') beginsWithEmpty: 'ß' caseSensitive: true).
	self assert: ('éèàôüößäóñíá' beginsWithEmpty: (self sliceFor:'éèàô') caseSensitive: true).
	self deny: ((self sliceFor:'éèàôüö') beginsWithEmpty: (self sliceFor:'ÉÈÀ') caseSensitive: true)
]

{ #category : #'tests - converting' }
StringSliceAsStringTest >> testCapitalized [
	| uc lc empty |
	uc := self sliceFor: 'MElViN'.
	lc := self sliceFor: 'mElViN'.
	empty := ' '.
	self assert: lc capitalized equals: uc.
	self assert: uc capitalized equals: uc.
	"the string gets copied"
	self deny: uc capitalized identicalTo: uc.
	self deny: empty capitalized identicalTo: empty
]

{ #category : #tests }
StringSliceAsStringTest >> testCaseInsensitiveLessOrEqual [

	self assert: ((self sliceFor: 'EEA') caseInsensitiveLessOrEqual: 'fgh').
	self deny: ('éèàôüößäóñíá' caseInsensitiveLessOrEqual: (self sliceFor: 'éèàôüöß') ).
	self assert: ((self sliceFor: 'éèàôüößäóñíá') caseInsensitiveLessOrEqual: 
		(self sliceFor: 'éèàôüößäóñíá'))
]

{ #category : #tests }
StringSliceAsStringTest >> testCaseSensitiveLessOrEqual [

	self assert: ((self sliceFor:'EEA') caseSensitiveLessOrEqual: 'fgh').
	self deny: ((self sliceFor:'éèàôüößäóñíá') caseSensitiveLessOrEqual: 'éèàôüöß'). 
	self assert: ((self sliceFor:'éèàôüößäóñíá') caseSensitiveLessOrEqual: 'éèàôüößäóñíá').
	self assert: ('ÉÈÀÔÜÖ' caseSensitiveLessOrEqual: (self sliceFor:'èàôüö')).
	self assert: ('eea' caseSensitiveLessOrEqual: (self sliceFor:'ÉÈÀ'))
]

{ #category : #tests }
StringSliceAsStringTest >> testCharactersExactlyMatching [

	self assert: 5 equals: ( (self sliceFor:'voiture') charactersExactlyMatching: 'voituze').
	self assert: 0 equals: ('voiture' charactersExactlyMatching: (self sliceFor:'')).
	self assert: 0 equals: ((self sliceFor:'voiture') charactersExactlyMatching: (self sliceFor:'car'))
]

{ #category : #tests }
StringSliceAsStringTest >> testCompare [

	self assert: ((self sliceFor: 'EEA') compare: 'fgh') equals: 1.
	self assert: ('ABCDEFGH' compare: (self sliceFor: 'ABCDEFGH')) equals: 2.
	self assert: ((self sliceFor: 'fgh') compare: (self sliceFor: 'fg')) equals: 3.
]

{ #category : #tests }
StringSliceAsStringTest >> testCompareCaseSensitive [

	self assert: ((self sliceFor:'EEA') compare: 'fgh' caseSensitive: true) equals: 1.
	self assert: ('ABCDEFGH' compare: (self sliceFor:'abcdefgh') caseSensitive: false) equals: 2.
	self assert: ((self sliceFor:'fgh') compare: (self sliceFor:'fg') caseSensitive: false) equals: 3.
]

{ #category : #'tests - comparing' }
StringSliceAsStringTest >> testComparing [
	self assert: (self sliceFor: 'foo') < 'foo:'.
	self assert: 'foo' < (self sliceFor: 'fooBar').
	self assert: (self sliceFor: 'foo') <= (self sliceFor: 'foo:').
]

{ #category : #'tests - copy' }
StringSliceAsStringTest >> testCopyEmptyMethod [
	| result |
	result := self collectionWithoutEqualElements copyEmpty.
	self assertEmpty: result.
]

{ #category : #'tests - copy' }
StringSliceAsStringTest >> testCopyNonEmptyWithoutAllNotIncluded [
	
]

{ #category : #'tests - copy' }
StringSliceAsStringTest >> testCopyReplaceAllWith [
	self assert: ((self sliceFor:'--A--') copyReplaceAll: 'A' with: 'ABC') equals: '--ABC--'.
	self assert: ('--ABC--' copyReplaceAll: (self sliceFor:'ABC') with: 'X') equals: '--X--'.
	self assert: ('A--A--A' copyReplaceAll: 'A' with: (self sliceFor:'ABC')) equals: 'ABC--ABC--ABC'.
]

{ #category : #'tests - copy' }
StringSliceAsStringTest >> testCopyReplaceAllWithAsTokens [

	self assert: ((self sliceFor:'test te str') copyReplaceAll: 'te' with: 'longone' asTokens: true) equals: 'test longone str'.
	self assert: ('test te str' copyReplaceAll: (self sliceFor:'te') with: 'longone' asTokens: false) equals: 'longonest longone str'.
	self assert: ('123 test xyz' copyReplaceAll: 'st' with: (self sliceFor:'mper') asTokens: true) equals: '123 test xyz'.
]

{ #category : #'tests - comparing' }
StringSliceAsStringTest >> testCorrectAgainst [

	| coll |
	coll := OrderedCollection new addAll: #('nest' 'temperature' 'text' 'Jupiter' 'denial' 'nest' 'tttt' 'e' 'alpha' 'beautest'); yourself.

	self assert: ((self sliceFor:'test') correctAgainst: coll) asArray equals: #('beautest' 'nest' 'text' 'nest' 'tttt' 'temperature').
	
	coll := coll collect: [ :s | self sliceFor: s ].
	self assert: ('test'correctAgainst: coll) asArray equals: #('beautest' 'nest' 'text' 'nest' 'tttt' 'temperature').
]

{ #category : #'tests - printing' }
StringSliceAsStringTest >> testDisplayString [

	| actual |
	actual := (self sliceFor: 'some string') displayString.
	self assert: actual equals: 'some string'
]

{ #category : #tests }
StringSliceAsStringTest >> testEndsWith [ 

	self deny: ((self sliceFor: 'éèàôüößäóñíá') endsWith: 'ia').
	self deny: ('éèàôüößäóñíá' endsWith: (self sliceFor: '')).
	self assert: ((self sliceFor: 'éèàôüößäóñíá') endsWith: (self sliceFor: 'éèàôüößäóñíá')).

]

{ #category : #'tests - testing' }
StringSliceAsStringTest >> testEndsWithAColon [

	self assert: (self sliceFor: 'fred:') endsWithAColon.

	self deny: (self sliceFor: 'fred') endsWithAColon
]

{ #category : #tests }
StringSliceAsStringTest >> testEndsWithAnyOf [

	self deny: ((self sliceFor: 'éèàôüößäóñíá') endsWithAnyOf: #('ia' 'ñí' '' 'áß')).
	self assert: ('éèàôüößäóñíá' 
		endsWithAnyOf: (#('test' 'ÉÈÀ' 'äóñíá') collect: [:s| self sliceFor: s]))

]

{ #category : #tests }
StringSliceAsStringTest >> testEndsWithDigit [

	self assert: ((self sliceFor:'éèàôüößäóñíá9') endsWithDigit).
]

{ #category : #tests }
StringSliceAsStringTest >> testEquality [
	
	self assert: (self sliceFor: 'abc') equals: 'abc' asWideString.
	self assert: (self sliceFor: 'abc') asWideString equals: 'abc'.


]

{ #category : #'tests - formatting' }
StringSliceAsStringTest >> testExpandMacros [

	self
		assert: (self sliceFor: '<t><n><r><l>') expandMacros
		equals:
			(String
				streamContents: [ :stream | 
					stream
						nextPut: Character tab;
						nextPutAll: OSPlatform current lineEnding;
						nextPut: Character cr;
						nextPut: Character lf ])
]

{ #category : #tests }
StringSliceAsStringTest >> testFindAnySubstringStartingAt [

	self assert: ((self sliceFor: 'tester12345') findAnySubstring: #('st' $1) startingAt: 1) equals: 3.
	self assert: ((self sliceFor: 'éèàôüößäóñíá1234') findAnySubstring: #('st' '' 'óñ' '123') startingAt:  1) equals: 9.
	self assert: (('éèàôüößäóñíá') findAnySubstring: #('') startingAt: 2) equals: 13.
	self assert: ((self sliceFor: 'éèàôüößäóñíá') findAnySubstring: #('óñ') startingAt: 3) equals: 9.
	self assert: ((self sliceFor: 'éèàôüößäóñíá') findAnySubstring: #() startingAt: 3) equals: 13.
	self assert: ((self sliceFor: 'test12345' )findAnySubstring: #('"' '@') startingAt: 12) equals: 10
]

{ #category : #tests }
StringSliceAsStringTest >> testFindBetweenSubstrings [
 
	self assert: ((self sliceFor: 'éèà ôüößäó ñíá') findBetweenSubstrings: #(' ')) asArray equals: #('éèà' 'ôüößäó' 'ñíá').
	self assert: ((self sliceFor: 'ieaoftaaka') findBetweenSubstrings: #($a)) asArray equals: #('ie' 'oft' 'k').
	self assert: ((self sliceFor: 'this is an issue is it not') findBetweenSubstrings: #('is' 'not')) asArray 
                                               equals: #('th' ' ' ' an ' 'sue ' ' it ').
]

{ #category : #tests }
StringSliceAsStringTest >> testFindCloseParenthesisFor [

	self assert: ((self sliceFor: '(1 + 3(2 * 9) - 15)') findCloseParenthesisFor: 1) equals: 19.
	self assert: ((self sliceFor: '(1+(2-3))-3.14159') findCloseParenthesisFor: 1) equals: 9.
	self assert: ((self sliceFor: '(1+(2-3))-3.14159') findCloseParenthesisFor: 4) equals: 8.
	self assert: ((self sliceFor: '()') findCloseParenthesisFor: 10) equals: 3
]

{ #category : #tests }
StringSliceAsStringTest >> testFindStringStartingAt [

	self assert: ((self sliceFor: 'éèàôüößäóñíá') findString: 'ÉÈ' startingAt: 1) equals: 0.
	self assert: ((self sliceFor: 'éèàôüößäóñíá') findString: 'éè' startingAt: 10) equals: 0.
	self assert: ((self sliceFor: 'éèàôüößäóñíá') findString: 'ß' startingAt: 5) equals: 7.
	self assert: ((self sliceFor: 'salkjsdlkgfee') findString: 'lke' startingAt: 1) equals: 0.
	self assert: ((self sliceFor: 'salkjsdlkgfee') findString: 'ee'startingAt: 3) equals: 12.
	self assert: ((self sliceFor: ' ') findString: '' startingAt: 1) equals: 0
]

{ #category : #'tests - formatting' }
StringSliceAsStringTest >> testFormat [

	self
		assert: ((self sliceFor: 'This is {1} !') format: #('a test'))
		equals: 'This is a test !'.
]

{ #category : #'tests - formatting' }
StringSliceAsStringTest >> testFormatExtended [

	self
		assert: ( (self sliceFor: 'This is {foo} !') format: (Dictionary with: #foo->'a test'))
		equals: 'This is a test !'.

 	{ 
 		[ (self sliceFor: '\{ \} \\ foo {foo} bar {bar}') format: { #foo->12. #bar->'string' } asDictionary ] -> '{ } \ foo 12 bar string'. 
 		[ (self sliceFor: '\{ \} \\ foo {bar} bar {foo}') format: { 'bar'->12. 'foo'->'string' } asDictionary ] -> '{ } \ foo 12 bar string'. 
 		[ (self sliceFor: '\{x}') format: {} ] -> '{x}'. 
 		[ (self sliceFor: '\{x}{x}') format: { #x->$a } asDictionary ] -> '{x}a'. 
 	} do: [ :each | 
		self assert: each key value equals: each value ]
]

{ #category : #'tests - formatting' }
StringSliceAsStringTest >> testFormatFailures [

	self
		should: [ (self sliceFor: 'This is {foo} !') format: Dictionary new ]
		raise: KeyNotFound.
		
	self
		should: [ (self sliceFor: 'This is {1} !') format: Array new ]
		raise: SubscriptOutOfBounds.

]

{ #category : #tests }
StringSliceAsStringTest >> testHasWideCharacterFromTo [

	self assert: ((self sliceFor:'te€st') hasWideCharacterFrom: 1 to: 3).
]

{ #category : #'tests - includes' }
StringSliceAsStringTest >> testIncludesElementIsNotThere [
	
	self deny: (self nonEmpty includes: self elementNotInForOccurrences).
	self assert: (self nonEmpty includes: self nonEmpty anyOne).
	self deny: (self empty includes: self elementNotInForOccurrences)
]

{ #category : #tests }
StringSliceAsStringTest >> testIncludesSubstring [

	self assert: ((self sliceFor:'testing this string') includesSubstring: 'ring'). 
	self deny: ('éèàôüößäóñíá' includesSubstring: (self sliceFor:'a')). 
	self assert: ((self sliceFor:'éèàôüößäóñíá') includesSubstring: (self sliceFor:'ßä')).

]

{ #category : #tests }
StringSliceAsStringTest >> testIncludesSubstringCaseSensitive [

	self deny: ((self sliceFor: 'test this string') includesSubstring: 'Ring' caseSensitive: true ). 
	self assert: ((self sliceFor: 'test this string') includesSubstring: 'Ring' caseSensitive: false). 
	self deny: ('123éàôüöß' includesSubstring: (self sliceFor: '') caseSensitive: false). 
	self assert: ('123éàôüöß' includesSubstring: (self sliceFor: 'öß') caseSensitive: true).


]

{ #category : #tests }
StringSliceAsStringTest >> testIndexOf [

	self assert: ((self sliceFor: 'test this string') indexOf: $k) equals: 0.
	self assert: ((self sliceFor: 'test this string') indexOf: 't') equals: 0.
 
]

{ #category : #tests }
StringSliceAsStringTest >> testIndexOfWideCharacterFromTo [

	self assert: ((self sliceFor: '123éàôüÖẞ') indexOfWideCharacterFrom: 1 to: 9) equals: 9.
	self assert: ((self sliceFor: 'te€st') indexOfWideCharacterFrom: 1 to: 5) equals: 3.
	self assert: ((self sliceFor: 'te€st this string') indexOfWideCharacterFrom: 4 to: 10) equals: 0.
	self assert: ((self sliceFor: '€₤') indexOfWideCharacterFrom: 1 to: 2) equals: 1
]

{ #category : #tests }
StringSliceAsStringTest >> testIsWideString [

	self assert: (self sliceFor: '€₤') isWideString.
	self deny: (self sliceFor: 'test this string') isWideString. 
	self assert: (self sliceFor: ' test ₤') isWideString.
	self deny: (self sliceFor: '') isWideString. 
	self assert: (self sliceFor: 'éàôüÖẞ') isWideString.
	self deny: (self sliceFor: 'éàôüÖ') isWideString 
]

{ #category : #tests }
StringSliceAsStringTest >> testLessThan [

	self assert: ((self sliceFor: '@') < 'A').
	self assert: ('abcd' < (self sliceFor: 'à ô ü')).
	self assert: ((self sliceFor: 'xyz') < (self sliceFor: 'ß')).

]

{ #category : #'tests - comparing' }
StringSliceAsStringTest >> testMatch [
	| slices |
	slices := #('**' 'f**'  'f**o' 'f*' '*f*' 
					'f#*' 'f##' '*oo' '#oo' '*o*' '#o#' '#o*' '*o#'
				   'fo*' 'fo#' '*foo*' '###' '*#'  'f*#' 'f*#o') 
		collect: [ :s | (self sliceFor: s) ].
	slices do: [ :each | self assert: (each match: 'foo') ].
	slices := #('bar' 'foo#' '#foo' '*foo#' '#foo*' '*bar*') 
		collect: [ :s | (self sliceFor: s) ].
	slices do: [ :each |
		self deny: (each match: 'foo') ]
]

{ #category : #tests }
StringSliceAsStringTest >> testNew [
	self should: [self targetClass new] raise: Error.
]

{ #category : #tests }
StringSliceAsStringTest >> testOnlyLetters [

	self assert: (self sliceFor: 'abc98def') onlyLetters equals: 'abcdef'.


]

{ #category : #tests }
StringSliceAsStringTest >> testPadLeftTo [

	self assert: ((self sliceFor: 'a') padLeftTo: 3) equals: '  a'. 
	self assert: (self sliceFor: ('a' padLeftTo: 1)) equals: 'a'. 
	self assert: ('a' padLeftTo: 0) equals: (self sliceFor: 'a')
]

{ #category : #tests }
StringSliceAsStringTest >> testReadFrom [
	self 
		assert: (String readFrom: (self sliceFor: ($' asString, 'foo', $' asString)) readStream)
		equals: 'foo'.
	self 
		assert: (String readFrom: (self sliceFor: ($' asString, 'this ', $' asString, $' asString, ' is embedded', $' asString)) readStream)
		equals: 'this '' is embedded'.
	self 
		assert: (String readFrom: ((self sliceFor: '<whitespace>', $' asString, 'foo', $' asString, '<whitespace>')) readStream)
		equals: 'foo'.
	self
		assert: (String readFrom: (self sliceFor: 'this '' is embedded') printString readStream)
		equals: 'this '' is embedded'
]

{ #category : #'tests - streaming' }
StringSliceAsStringTest >> testReadStreamDo [
	string readStreamDo: [ :stream | self assert: stream contents equals: string ]
]

{ #category : #'tests - copying same contents' }
StringSliceAsStringTest >> testShuffled [
	^self
	"Should not support shuffling"
]

{ #category : #tests }
StringSliceAsStringTest >> testStoreOn [
	self assert: (String streamContents: [ :s | (self sliceFor: 'Foo''Bar') storeOn: s ]) equals: '''Foo''''Bar'''
]

{ #category : #'tests - converting' }
StringSliceAsStringTest >> testWithoutLeadingDigits [
	(#( 
		'foo' 'foo'
		'123foo' 'foo'
		'123 bar7' 'bar7'
		' 123 	bar7' 'bar7'
		'foo.123.txt' 'foo.123.txt'
		'' ''
		'1' ''
		'1 2 3 ' ''
	)  collect: [ :s | self sliceFor: s ])
	pairsDo: [ :input :output |
		self assert: input withoutLeadingDigits equals: output ]
	
]

{ #category : #requirements }
StringSliceAsStringTest >> unsortedCollection [
	^ unsortedCollection 
]

{ #category : #requirements }
StringSliceAsStringTest >> withEqualElements [
	" return a collection  including equal elements (classic equality)"
	^ sameAtEndAndBegining 	
]
