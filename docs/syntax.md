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

## from cheat sheat

FIXME
