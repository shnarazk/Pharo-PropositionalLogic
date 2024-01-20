# Syntax summary

## from post cart

```
true & false not & (nil isNil)
ifFalse: [ self perform: #add: with x ].

y := thisContext stack size + super size.

byteArray := #[ 2 2r100 8r20 16rFF ].    "integer literals"

"{} is an array generated at runtime separating elements by period"
"#() is a literal array, fixed-sized vector"
{ -42 . #($a #a #'I''m' 'a' 1.0 1.23e2 3.14s2 1) } do: [ :each |
  | var |
  var := Transcript
    show: each class name;
    show: each printString ].

^ x < y
```

## from cheat sheet

### Minimal Syntax

FIXME

|  word | meaning |
|--------|------------|
| `nix` | the undefined object |
| `true`, `false` | boolean objects |
| `self` | the receiver of the current message |
| `super` | the receiver of the superclass context |
| `thisContent` | the current invocation on the call stack |

|  punctuation | meaning |
|-----------------|------------|
| `"comment"` |  |
| `'string'` |    |
| `#symbol` | unique string |
| `$a` | the character `a` |
| `12` `2r1100` `16rC` | twelve (decimal, binary, hexadecimal) |
| `3.14` `1.2e3` | floating-point numbers |
| `.` | expression separator (period) |
| `;` | message cascae (semicolon) |
| `:=` | assignment |
| `^` | return a result from a method (caret) |
| `#(abc 123)` | literal array with the symbol `#abc` and the number `123` |
| `{foo . 3 + 2}` | dynamic array build from 2 expressions |

### Message Sending

A method is called by sending a message to an object, the message receiver; the message returns an object. Messages are modeled from natural languages, with a subject, a verb, and complements. There are three types of messages: unary, binary, and keyword.

A **unary message** is one with no arguments.

```smalltalk
Array new.
#(1 2 3) size.
```
The first example creates and returns a new instance of the `Array` class, by sending the message `new` to the class `Array` (that is an object). The second message returns the size of the literal array which is 3.

A **binary message** takes only one argument and is named by one or more symbol characters.

```smalltalk
   3 + 4.
  'Hello', 'World'.
```

The `+` message is sent to the object `3` with `4` as the argument. In the second case, the string `'Hello' `receives the message, (comma) with `'World'` as the argument.

A **keyword message** can take one or more arguments that are inserted in the message name.

```smalltalk
   'Smalltalk' allButFirst: 5.
   3 to: 10 by: 2.
```
The first example sends the message allButFirst: to a string, with the argument 5. This returns the string 'talk'. The second example sends to:by: to 3, with arguments 10 and 2; this returns a collection containing 3, 5, 7, and 9.

### Precedence

Parentheses > unary > binary > keyword, and finally from left to right.

```smalltalk
(10 between: 1 and: 2+4*3) not
```

Here, the messages + and * are sent first, then between:and: is sent, and finally not. The rule suffers no exception: operators are just binary messages with no notion of mathematical precedence, so 2 + 4 * 3 reads left-to-right and gives 18, not 14!

### Cascading Messages
Multiple messages can be sent to the same receiver with `;`. 

```smalltalk
OrderedCollection new
     add: #abc;
     add: #def;
     add: #ghi.
```

The message new is sent to OrderedCollection which results in a new collection to which 3 add: messages are sent. The value of the whole message cascade is the value of the last message sent (here, the symbol #ghi). To return the receiver of the message cascade instead (i.e., the collection), make sure to send yourself as the last message of the cascade.

### Blocks
Blocks are objects containing code that is executed on demand, (anonymous functions). They are the basis for control structures like conditionals and loops.

```smalltalk
2=2 ifTrue: [Error signal: 'Help'].
#('Hello World' $!)
     do: [:e | Transcript show: e]
```
The first example sends the message ifTrue: to the boolean true (computed from 2 = 2) with a block as argument. Because the boolean is true, the block is executed and an exception is signaled. The next example sends the message do: to an array. This evaluates the block once for each element, passing it via the e parameter. As a result, `Hello World!` is printed.

### Unit testing
Pharo has a minimal still powerful framework that supports the creation and deployment of tests. A test must be implemented in a method whose name has a test prefix and in a class that subclasses TestCase.

```smalltalk
OrderedCollectionTest >> testAdd

  | added |
  added := collection add: 'foo'.
  self assert: added == 'foo'.
  self assert: (collection includes: 'foo').
```

The `OrderedCollectionTest>>testAdd` notation indicates that the following text is the content of the method `testAdd` in the class `OrderedCollectionTest`. The second line declares the variable `added`. To execute unit-tests, open the `Test Runner` tool.

