### Ranges
```ruby
1..5  # => 1..5(inclusive)
1...5 # => 1...5 (Exclusive)
```

### Array/Hash
```ruby
colors[..1] == colors.take(2)  # take first 2 items from array


# to strings
%w[foo bar baz] # => ["foo", "bar", "baz"]
%w[1 % *]       # => ["1", "%", "*"]
# to symbols
%i[foo bar baz] # => [:foo, :bar, :baz]
%i[1 % *]       # => [:"1", :%, :*]

[".", nil, "s", nil].compact # => [".", "s"]
```

### String & Regex
```ruby
\b # matches word boundaries
\w # matches any word character
\W # matches any non-word character
\z # asserts position at the end of the string
String.chr # returns the first character of a string
String.upcase # returns the uppercase version of a string
# =~ operator matches the regular expression against a string,
/mi/ =~ "hi mike" # => 3
"hi mike" =~ /mi/ # => 3


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
```

### Console / irb
```shell

puts # adds new line after each argument
print # puts all args on same line, and "\n" needed

```
### Class
```shell
Class.instance_methods(include_super=false) # will output user-defined methods
