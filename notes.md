### Dates
```ruby
Date.today.strftime('%A') # weekday, e.g. Wednesday or Thursday
```

### Ranges
```ruby
1..5  # => 1..5(inclusive)
1...5 # => 1...5 (Exclusive)
(1..5).include?(5) == (1..5).cover?(5)
```

### Array
```ruby
colors[..1] == colors.take(2)  # take first 2 items from array
Array.unshift # puts element in front (that's O^n operation)

# perform extra manipulation for filtered items before returning
(0..9).filter_map {|i| i * 2 if i.even? } # [0, 4, 8, 12, 16]
# comparing to default filtering with original items filtered by criteria.
(0..9).filter {|i| i * 2 if i.even? } # 0, 2, 4, 6, 8]

# with no block given, returns original array as is.
[[0, 1], [0, 2]].flat_map # [[0, 1], [0, 2]]
# _1 here is a reference to elem
[[0, 1], [0, 2]].flat_map { _1 } # [0, 1, 0, 2]
# [[0, 1], [0, 2]].flat_map { |e| e } # [0, 1, 0, 2]

# to strings
%w[foo bar baz] # => ["foo", "bar", "baz"]
%w[1 % *]       # => ["1", "%", "*"]
# to symbols
%i[foo bar baz] # => [:foo, :bar, :baz]
%i[1 % *]       # => [:"1", :%, :*]

[".", nil, "s", nil].compact # => [".", "s"]

[1,2,3].pop # => 3, removes and returns trailing element from array in-place

# is there any element in array which has no reminder from division of 5
# _1 -> first position argument passed, <element> in this case
[5, 2, 1].any? { (5 % _1).zero? }
```

### Hash
```ruby

Hash.key # Returns the key for the first-found entry with the given value OR nil
```

### String
```ruby
String.tr
# Negation
'hello'.tr('^aeiou', '-') # => "-e--o"
# Ranges.
'ibm'.tr('b-z', 'a-z') # => "hal"
# Escapes.
'hel^lo'.tr('\^aeiou', '-')     # => "h-l-l-"    # Escaped leading caret.
'i-b-m'.tr('b\-z', 'a-z')       # => "ibabm"     # Escaped embedded hyphen.
'foo\\bar'.tr('ab\\', 'XYZ')    # => "fooZYXr"   # Escaped backslash.


String.reverse # Returns a new string with the characters from self in reverse order.
String.reverse! # Returns self with its characters reversed (in-place)

# The primary purpose of this method is to "tap into" a method chain,
# in order to perform operations on intermediate results within the chain.
String.tap
    (1..10)                .tap {|x| puts "original: #{x}" }
    .to_a                  .tap {|x| puts "array:    #{x}" }
    .select {|x| x.even? } .tap {|x| puts "evens:    #{x}" }
    .map {|x| x*x }        .tap {|x| puts "squares:  #{x}" }
# original: 1..10
# array:    [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
# evens:    [2, 4, 6, 8, 10]
# squares:  [4, 16, 36, 64, 100]

# Squeezed" means that each multiple-character run of a selected
# character is squeezed down to a single character; with no arguments
"  now   is  the".squeeze(" ")         #=> " now is the"

"".to_i == 0  # true

```
### Regex
https://en.wikipedia.org/wiki/Regular_expression#Character_classes

```ruby
\b # matches word boundaries
\w # matches any word character(including digits)
\W # matches any non-word character(excluding digits)
\z # asserts position at the end of the string
String.chr # returns the first character of a string
String.upcase # returns the uppercase version of a string
# =~ operator matches the regular expression against a string,
/mi/ =~ "hi mike" # => 3
"hi mike" =~ /mi/ # => 3

# In ruby/rust both of these will match ASCII + unicode chars, but no in java e.g.
/\p{Alpha}/gu # matches any characters in the Alpha script extension(unicode inclusive)
/\p{L}/gu # matches any kind of letter from any language(unicode inclusive)

\1 # matches the same text as most recently matched by the 1st capturing group

String.scan(/[[:alnum:]]/) # matches alpha numeric chars only
```

### Console / irb
```shell

puts # adds new line after each argument
print # puts all args on same line, and "\n" needed

```
### Class
```shell
Class.instance_methods(include_super=false) # will output user-defined methods


### Parallelism & Concurrency
Ruby process -> Main Thread -> N Threads
Heap - where you store variables / consts / any data literlaly.
Threads have access to same heap, which is quite convenient.

Parallelism -> 200 people working on 200 tasks
Concurrency -> 200 people working on 100 tasks(context switching for some of those)
# join back with main thread, wait until going on
# don't finish at the same order, each thread acts independently from each other(async)


### Debugging
require 'byebug'

byebug


TODO:
- because of '—', '’' chars test debugging does not work. holy crap!!
fckng bug, which should be addressed. Something might be with unicode chars??
SAVING as unicode with BOM solved the issue.. holy moly
