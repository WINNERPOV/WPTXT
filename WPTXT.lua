WPTXT = {}

WPTXT.OBJECTS = {}
WPTXT.FILENAME = ""
WPTXT.NIL = "%NIL%"

local function OBJECT(name, values)
    local object = {}
    object.name = name
    object.values = values
    return object
end

local function VALUE(name, type, val)
    local object = {}
    object.name = name
    object.type = type
    object.val = val
    return object
end

local function WPTXTMessage(message)
    local prefix = "["..WPTXT.FILENAME.."]: "
    print(prefix..message)
end

local function StartsWith(String, Start)
    return string.sub(String,1, string.len(Start)) == Start
end

local function SplitString(str, regex)
    if regex == nil then regex = "%s" end
    local list = {}
    for word in string.gmatch(str, "([^" .. regex .. "]+)") do
        table.insert(list, word)
    end
    return list
end

local function GetValue(objectName, valueName)
    for ind1, object in ipairs(WPTXT.OBJECTS) do
        if object.name == objectName then
            for ind2, value in ipairs(object.values) do
                if value.name == valueName then
                    return value
                end
            end
        end
    end
    return nil
end

local function LuaTypeToWPTXT(value)
    local type = type(value):upper()
    if type == "TABLE" then
        return "LIST"
    elseif type == "NIL" then
        return "NOTHING"
    end
    return type
end

local function LuaToWPTXT(value)
    local type = type(value)
    if type == "string" then
        return value
    elseif type == "number" or type == "boolean" then
        return tostring(value)
    elseif type == "table" then
        local t = ""
        for ind3, v in ipairs(value) do
            if ind3 == #value then
                t = t .. tostring(v)
            else
                t = t .. tostring(v) .. "|"
            end
        end
        return t
    elseif type == "nil" then
        return WPTXT.NIL
    end
end

local function WPTXTToLua(value)
    if value.type == "STRING" then
        return tostring(value.val)
    elseif value.type == "NUMBER" then
        return tonumber(value.val)
    elseif value.type == "BOOLEAN" then
        local boolean = false
        if tostring(value.val):upper() == "true" then
            boolean = true
        end
        return boolean
    elseif value.type == "LIST" then
        return SplitString(value.val, "|")
    elseif value.type == "NOTHING" then
        return WPTXT.NIL
    end
end

function WPTXT:OPEN(fileName)
    WPTXT.OBJECTS = {}
    WPTXT.FILENAME = fileName .. ".WPTXT"
    local objectName = ""
    local objectValues = {}
    for line in io.lines(WPTXT.FILENAME) do
        if line == "<-" then
            local object = OBJECT(objectName, objectValues)
            table.insert(WPTXT.OBJECTS, object)
            objectValues = {}
        elseif StartsWith(line, "->") then
            local name = string.sub(line, 3, string.len(line))
            objectName = name
        elseif not StartsWith(line, "#") and line:find("?") ~= nil and line:find(":") ~= nil then
            if line:find("?") < line:find(":") then
                local l = SplitString(line, ":")
                local half = SplitString(l[1], "?")
                local name = half[1]
                local type = half[2]
                local value = VALUE(name, type, l[2])
                table.insert(objectValues, value)
            end
        end
    end
end

function WPTXT:GET(objectName, valueName)
    local value = GetValue(objectName, valueName)
    return WPTXTToLua(value)
end

function WPTXT:OBJ(name)
    for ind4, obj in ipairs(WPTXT.OBJECTS) do
        if obj.name == name then
            return obj
        end
    end
    local newObject = OBJECT(name, {})
    table.insert(WPTXT.OBJECTS, newObject)
    return newObject
end

function WPTXT:ADD(objectName, valueName, val)
    local type = LuaTypeToWPTXT(val)
    local value = VALUE(valueName, type, LuaToWPTXT(val))
    local object = WPTXT:OBJ(objectName)
    if GetValue(objectName, valueName) == nil then
        if (value.val == nil) then
            value.type = "NOTHING"
        end
        table.insert(object.values, value)
    else
        WPTXTMessage("\""..valueName.."\" already exists!")
    end
end

function WPTXT:SET(objectName, valueName, val)
    local value = GetValue(objectName, valueName)
    local type = LuaTypeToWPTXT(val)
    if value.type == type or type == "NOTHING" or value.type == "NOTHING" then
        if value ~= nil then
            value.type = type
            value.val = val
        else
            WPTXTMessage("The value \"" .. valueName .. "\" does not exist in this object!")
        end
    else
        WPTXTMessage("Attempt to assign type \""..type.."\" to a value with type \""..value.type.."\"!")
    end
end

function WPTXT:SAVE()
    local file = io.open(WPTXT.FILENAME, "w")
    local text = ""
    for ind1, object in ipairs(WPTXT.OBJECTS) do
        text = text .. "->" .. object.name .. "\n"
        for ind2, value in ipairs(object.values) do
            text = text .. value.name .. "?" .. value.type .. ":" .. LuaToWPTXT(value.val) .. "\n"
        end
        text = text .. "<-\n"
    end
    file:write(text)
    file:close()
    WPTXT.OBJECTS = {}
    WPTXT.FILENAME = ""
end

return WPTXT