local WPTXT = require("WPTXT")

WPTXT:OPEN("Test")

WPTXT:OBJ("Account")

WPTXT:ADD("Account", "FullName", "Mark Mjaucher") --STRING
WPTXT:ADD("Account", "Login", nil) --NOTHING
WPTXT:ADD("Account", "Age", 26) --NUMBER
WPTXT:ADD("Account", "PhoneNumbers", { "+355-69-123-4567", "+355-69-711-0711" }) --LIST
WPTXT:ADD("Account", "IsPrivate", false)

local FullName = WPTXT:GET("Account", "FullName")
local PhoneNumbers = WPTXT:GET("Account", "PhoneNumbers")

print(FullName)

for ind, pnumber in ipairs(PhoneNumbers) do
    print(pnumber)
end

print(WPTXT:GET("Account", "Login"))

WPTXT:SET("Account", "Login", false)

print( WPTXT:GET("Account", "Login"))

WPTXT:SAVE()