# StringBuilder

I sometimes find the building of large strings cumbersome if I have to pass a stream around. Class StringBuilder is my attempt to overcome this by making an efficient concatenation for strings.

The concatenation operator is called `<<` to mirror that of normal streaming.

Class StringBuilder loads together with the StringSlice (though they do not depend on each other).

```smalltalk
('aaa' << 'bbb') contents >>> 'aaabbb'.
```


### Implementation
The StringBuilder has an OrderedCollection of strings and StringBuilders. The `<<` operator adds to this ordered collection, and returns the stringbuilder itself so it can accept more `<<` invocations.


When `<<` is invoked on a string, it creates a stringbuilder, and that stringbuilder is used henceforth in building the string. 

```smalltalk
<< other	"other should be either a String or a StringBuilder"	^(StringBuilder on: self) << other
```

To get the full string accumulated so far, the method `contents` combines the whole structure of `String` and `StringBuilders` into a string, using a stream. 


