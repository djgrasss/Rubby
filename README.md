# Rubby

Rubby (ru bub ee) is a little language on top of Ruby. Rubby has a simpler,
more concise syntax than Ruby, but gives you access to most of Ruby's
primitives and capabilities. Rubby is billed as "Ruby; the good parts" and
as such is an opinionated language, it does it's best to give you access to
the expressiveness and flexibility of Ruby whilst getting rid of some of the
unnecessary syntax and removing some of Ruby's language features which may
be considered traps for young players.

Rubby consists of a transpiler, which outputs idiomatic Ruby, and an
"interpreter" which executes Rubby as if it was the corresponding Ruby code.

## Status

[![Build Status](https://travis-ci.org/jamesotron/Rubby.png)](https://travis-ci.org/jamesotron/Rubby)
[![Dependency Status](https://gemnasium.com/jamesotron/Rubby.png)](https://gemnasium.com/jamesotron/Rubby)
[![Code Climate](https://codeclimate.com/github/jamesotron/Rubby.png)](https://codeclimate.com/github/jamesotron/Rubby)

Features required for 1.0 release:

 + Lexer ✓
 + Parser (*in progress*)
 + Transpiler
 + Interpreter
 + Polyglot interface (https://github.com/cjheath/polyglot)

Rubby is in it's infancy, pull requests are greatly appreciated.

## Syntax examples

### Primitives:

#### Comments:

```rubby
# I am a comment
```

#### Integers

```rubby
123    # decimal
0x123  # hexidecimal
0123   # octal
0x101  # binary
```

#### Floating point

```rubby
1.23
```

#### Strings

```rubby
'foo'            # basic string with no special characters
"foo\n"          # complex string, which can contain escaped characters
"foo #{bar} baz" # complex string with interpolation
```

#### Symbols

```rubby
:foo              # simple symbol, which contain upper and lower case letters, numbers and underscores
:"foo bar"        # complex symbol which can contain any string
:"foo #{bar} baz" # complex symbol with interpolation
```

#### Regular expressions

```rubby
/^foo$/    # basic regular expression
/^#{bar}$/ # regular expression with interpolation
```

#### Arrays

```rubby
[1,1.2,'foo',"foo",:foo]
```

#### Hashes

```rubby
foo: 1, 'bar': 2, 3: 4
```

Rubby will detect the Ruby environment and decide whether to output old fashioned (Ruby 1.8 style)
hashes:

```ruby
{ :foo => 1, 'bar' => 2, 3 => 4 }
```

or the newer (Ruby >= 1.9) syntax:

```ruby
{ foo: 1, 'bar' => 2, 3 => 4 }
```

This can be overridden by specifying the target version on the transpiler command line.

#### Defining methods

Methods are defined using the following format:

    |modifiers|method name|-> (arguments)

Method modifiers are `@` to indicate a class method and `_` to indicate a private method.

```rubby
# an empty instance method
my_method-> (arg1, arg2)

# an isntance method with contents
my_second_method-> (*args)
  puts args.inspect

# a private method
_my_private_method-> (*args)
  args

# a class method
@my_class_method-> (*args)
  args

# a private class method
@_my_private_class_method-> (*args)
  args
```

```ruby
def my_method(arg1, arg2); end

def my_second_method(*args)
  puts args.inspect
end

private
def my_private_method(*args)
  args
end

def self.my_class_method(*args)
  args
end

class << self
  private
  def my_private_class_method(*args)
    args
  end
end
```

#### Blocks

Blocks are passed using the special `&>` operator. Blocks can take arguments
(specified within braces `()` after the `&>`) and either a single expression
on the same line, or multiple expressions indented below:

```rubby
(1..5).each &> (i) puts i  # single expression block with argument

(1..5).chunk &> (i)
  if i.prime?
    i**i
  else
    i
```

```ruby
(1..5).each { |i| puts i }

(1..5).each do |i|
  if i.prime?
    i ** i
  else
    i
  end
end
```

#### Modules

```rubby
module Foo # simple module with no contents

module Bar
  bar->
    puts "raise the bar!"
```

```ruby
Foo = Module.new

module Bar
  def bar
    puts "raise the bar!"
  end
end
```

#### Classes

```rubby
class Foo             # simple class with no contents
class Foo < Exception # simple class, which inherits from Exception with no contents

class Cat
  @open->(what)
    puts "Cat cannot open #{what}"
```

```ruby
Foo = Class.new
Foo = Class.new(Exception)

class Cat
  def self.open(what)
    puts "Cat cannot open #{what}"
  end
end
```

## Installation

Add this line to your application's Gemfile:

    gem 'rubby'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rubby

## Copyright

Copyright (c) 2013 Sociable Limited and named contributors:

### Contributors

 + [James Harton](https://github.com/jamesotron)

## License

### MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

