local Compiler = require("Bytecode.Compiler")
local Deserializer = require("Bytecode.Deserializer")
local Serializer = require("Bytecode.Serializer")

local Generate = require("VM.Generation")

local Parse = require("Minifier.ParseLua").ParseLua
local Minify = require("Minifier.FormatMini")
local Beautify = require("Minifier.FormatBeautiful")

local fs = require("Utils.fs")

return(function()
    local Code = fs.readFile("./Script.lua")
    local Bytecode = Compiler(Code, "NekoLuaAlpha")
    local Chunk = Deserializer(Bytecode)
    local SerializedBytecode = Serializer(Chunk)

    _G.UsedOps[0] = 0 -- closure
    _G.UsedOps[4] = 4 -- closure
    
    local VMOut = Generate(SerializedBytecode, _G.UsedOps)
    local _, AST = Parse(VMOut)
    
    VMOut = Minify(AST)
    
    fs.writeFile("./Output.lua", VMOut)
end)()