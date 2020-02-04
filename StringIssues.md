# String Issues
When one dive into any piece of code, one is likely to encounter a few places with less than optimal code. 

In the work with making StringSlice, I wanted StringSlice to be a subclass of String, so I could inherit its many methods.

That has not been without issues. I will mention them here.

Notice, that String is not from its design an abstract superclass for ByteString and WideString. It is a class which assumes that only those two classes are subclass of String:

> Class String provides the abstract super class for ByteString (that represents an array of 8-bit Characters) and WideString (that represents an array of  32-bit characters).  In the similar manner of LargeInteger and SmallInteger (class comment of String).

The following *issues* are thus issues which arise when I want to misuse String as a true abstract superclass, and implement a third subclass. One can say *I asked for it*.

Nevertheless, here I go:

### class and species
In class Object, the method species is documented as:

>species	"Answer the preferred class for reconstructing the receiver...

Well, for that to work, one should use `self species new` rather than `self class new` to get new instances. As `StringSlice` cannot implement new because it need both an existing string and two indexes, `StringSlice` implement `species` to return String.

It just turn out there are around 15 methods in String which use `self class` where they should have used `self species`. There are also a number of methods which use self species, those caused me no issues.

In class StringSlice those methods are overridden and changed to use species as they should.

### Subclass specific default implementation
Several places in the class hierarchy is the patten that a default implementation is given, which is then overridden in some subclasses. The method `isCollection` is one example. 

However, there are a few places where a method is implemented in String, and then overridden in either ByteString or WideString. 

For example the method `asLowercase`, where the implementation is given in `String`, and overridden in `WideString`. In essence, this method should not have an implementation in `String`, but one in `ByteString` and one in `WideString`.

### Superclass assumes subclass to be variable
String is a regular class whereas ByteString and WideString are variableSubclasses. Actually, there is only one method in String which make use of that assumption, which is alike:. It does so in this subtle way:

```smalltalk
alike: aString 	"stuff deleted..."
	[(i <= minSize) and: [((super at: i) bitAnd: 16rDF)  = ((aString at: i) asciiValue bitAnd: 16rDF)]]		whileTrue: [ i := i + 1 ].
```

The culpit is `super at:`, which pushes the indexing up to the implementation in `Object`, where it is assumed that the sender is variable and indexable. But alas, `StringSlice` is directly indexable. 

I just need to rewrite `(super at: i)` to `(self at: i) asInteger` the two places in the method. 

There is a code smell "sends different super message", which applies here.

## Conclusion
String implements 300+ methods. In the end, my abuse of making a new subclass which was not intended caused trouble with less than 20. Of those were 15 the class/species problem. String and its two subclasses have been here for a long time and are in my view well architected.




