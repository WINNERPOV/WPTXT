# [![WPTXT Logo](Logo.png)](https://github.com/WINNERPOV/WPTXT)
[WPTXT](https://github.com/WINNERPOV/WPTXT) is a programming language for storing and exchanging data, written for lua.

# Syntax:

## Types

There are five Types in [WPTXT](https://github.com/WINNERPOV/WPTXT): `STRING`, `NUMBER`, `BOOLEAN`, `LIST`, `NOTHING`. The `NOTHING` Type is returned by interpreter if the value is equals `nil`. Value with Type `BOOLEAN` can only be equal to either `True` or `False`. 

## Values

All Values have Name and Type:

```swift
Value1?STRING:WPTXT
Value2?NUMBER:123.45
Value3?BOOLEAN:true
Value4?LIST:One|Two|Three|Four|Five
Value5?NOTHING:%NIL%
```

## Objects

Objects are needed to store values. They must have their own Name and be denoted by `->` `<-` at the beginning and at the end:

```swift
->Account
FullName?STRING:Mark Mjaucher
Login?NOTHING:%NIL%
Age?NUMBER:26
PhoneNumbers?LIST:+355-69-123-4567|+355-69-711-0711
Private?BOOLEAN:True
<-
```

There can be an unlimited number of Objects in one file.

# Getting started with WPTXT

## 1. Initialization

The WPTXT.lua file needs to be thrown into the project and required from it:

```lua
WPTXT = require("WPTXT")
```

The next step is to `OPEN` the file:

```lua
WPTXT:OPEN("Test") --Test is the file name (Test.WPTXT)
```

## 2. Methods:

### 2.1 OBJ()

Function `OBJ()` сreates a new `Object`:

```lua
WPTXT:OBJ("Account")
```

### 2.2 ADD()

Function `ADD()` сreates a new `Value`:

```lua
WPTXT:ADD("Account", "FullName", "Mark Mjaucher") --STRING

WPTXT:ADD("Account", "Login", nil) --NOTHING

WPTXT:ADD("Account", "Age", 26) --NUMBER

WPTXT:ADD("Account", "PhoneNumbers", { "+355-69-123-4567", "+355-69-711-0711" }) --LIST

WPTXT:ADD("Account", "Private", false) --BOOLEAN
```

### 2.3 GET()

Function `GET()` gives `Value`:

```lua
local FullName = WPTXT:GET("Account", "FullName")
local PhoneNumbers = WPTXT:GET("Account", "FullName")

print(FullName)

for ind, pnumber in ipairs(PhoneNumbers) do
   print(pnumber)
end

> Mark Mjaucher
> +355-69-123-4567
> +355-69-711-0711
```

### 2.4 SET()

Function `SET()` changes `Value`:

```lua
local FullName = WPTXT:GET("Account", "FullName")
local PhoneNumbers = WPTXT:GET("Account", "FullName")

print(FullName)

for ind, pnumber in ipairs() do
   print(pnumber)
end

> Mark Mjaucher
> +355-69-123-4567
> +355-69-711-0711
```

## 3. Finishing

To save your progress, use the `SAVE()` function:

```lua
WPTXT:SAVE()
```

# License

[WPTXT](https://github.com/WINNERPOV/WPTXT) is distributed under the terms of the [MIT License](https://github.com/WINNERPOV/WPTXT/blob/main/LICENSE).
