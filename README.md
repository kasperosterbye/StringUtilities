# StringSlice

A stringslice a substring obtained by a `start` and `end` index into an existing string. It is thus possible to get substrings without copying the bytes of the original string - at least for a large number of operations.

The package adds one extra method to class String: the sliceFrom: a to: b. 

```smalltalk
slice := 'aaabbbccc' sliceFrom: 4 to: 6.slice size >>> 3.(slice at: 2) >>> $b
```

The library also contains a small class StringBuilder. See [StringBuilder.md](StringBuilder.md).

## Metacello call


```smalltalk
Metacello new
   baseline: 'StringUtilities';
   repository: 'github://kasperosterbye/StringUtilities';
   load.
```

## Implementation notes

### Imutable
StringSlice does not allow changes to the original string. 

* Some mutatation operations will give an error - `at:put:` is not allowed.
* Other mutation operations already have copy semantics for String, for example asUppercase. These copying methods do not return a slice, but a String.

### Complete
I have tried my best to make sure slices respond to the same protocol as String.

While the Metacello expression above do not load the tests, I have ported all the non-destructive tests from string to make sure all string methods work on slices. Any missing issue - please raise them. 

### Effecient 
A large number of methods return slices if used on a slice. For example:

* The substrings: method return slices if the original is a slice.
* Regular expression matching returns slices if the original is a slice.

```smalltalk
slice := 'aaa bbb ccc' sliceFrom: 1 to: 11.((slice substrings: ' ') collect: [:s | s class]) >>>    {StringSlice. StringSlice. StringSlice}.
    
'(a+|c+)' asRegex  matchesIn: slice. "returns slices"
```

The slice has three instance variables, the original string, start and end. Making them is therefore rather fast. In fact my timings show it is faster to make a zero length slice than a zero length string copy. There are some timing methods in the StringSlice class side. Perhaps yours computer is different than mine.

### Comments onString
While I have been testing Slice, I have come across a number of issues with the class String. They are summarized in [StringIssues](StringIssues.md).
