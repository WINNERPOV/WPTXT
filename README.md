# [![WPTXT Logo](Logo.png)](https://github.com/WINNERPOV/WPTXT)
[WPTXT](https://github.com/WINNERPOV/WPTXT) is a programming language for storing and exchanging data, written for lua.

# Syntax:

# Types

There are five Types in [WPTXT](https://github.com/WINNERPOV/WPTXT): `STRING`, `NUMBER`, `BOOLEAN`, `LIST`, `NOTHING`. The `NOTHING` Type is returned by interpreter if the value is equals `nil`. Value with Type `BOOLEAN` can only be equal to either `True` or `False`. 

# Values

All Values have Name and Type:

```swift
Value1?STRING:WPTXT
Value2?NUMBER:123.45
Value3?BOOLEAN:true
Value4?LIST:One|Two|Three|Four|Five
Value5?NOTHING:%NIL%
```

# Objects

Objects are needed to store Values. They must have their Name and be denoted by the characters `->` `<-` at the beginning and at the end:

```swift
->Account
ID?NUMBER:1
Login?STRING:mjaucher1
Password?STRING:abc12345
<-
```

There can be an unlimited number of Objects in one file.

# Getting started with WPTXT



# License

[WPTXT](https://github.com/WINNERPOV/WPTXT) is distributed under the terms of the [MIT License](https://github.com/WINNERPOV/WPTXT/blob/main/LICENSE).
