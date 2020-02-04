# StringBuilder

I sometimes find the building of large strings cumbersome if I have to pass a stream around to stream all the parts into. Class StringBuilder is my attempt to overcome this by making an efficient concatenation for strings.

At the moment the concatenation operator is called `,+` because that operator was not in use.

Class StringBuilder loads together with the StringSlice (though they do not depend on each other), I could split it to an other repository.

```smalltalk
'aaa' ,+ 'bbb' >>> 'aaabbb'.
'xxx' ,+ obj stringBuildingMethod ,+ 'yyy'.
```


### Implementation
The StringBuilder has an OrderedCollection of strings and StringBuilders. The `,+` operator adds to this ordered collection, and returns the stringbuilder itself so it can accept more `,+` invocations.


When ,+ is invoked on a string, it creates a stringbuilder, and that stringbuilder is used henceforth in building the string. 

```smalltalk
,+ other	"other should be either a String or a StringBuilder"	^(StringBuilder on: self) ,+ other
```

To get the full string accumulated so far, the method `asString` combines the whole structure of `String` and `StringBuilders` into a string using a stream. 

### doesNotUnderstand:
StringBuilder is a subclass of ProtoObject to inherit as little as possible. It has a doesNotUnderstand: method which first linearize itself using asString, and then send the message to the linearized string. To avoid doing this over and over, it caches (compiles actually) methods to make StringBuilders behave as much as a string as possible. 

In essence, this sums up as the StringBuilder computes its string the first time one use it for anything other than building the string.


