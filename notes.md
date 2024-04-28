### Ranges
```ruby
1..5  # => 1..5(inclusive)
1...5 # => 1...5 (Exclusive)
```

### Array/Hash
```ruby
colors[..1] == colors.take(2)  # take first 2 items from array
```

### String & Regex
```shell
\b # matches word boundaries
\w # matches any word character
\W # matches any non-word character
String.chr # returns the first character of a string
String.upcase # returns the uppercase version of a string

String.reverse # Returns a new string with the characters from self in reverse order.
String.reverse! # Returns self with its characters reversed (in-place)
```
