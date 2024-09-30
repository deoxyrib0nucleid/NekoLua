local Compiler = require("Bytecode.Compiler")
local Deserializer = require("Bytecode.Deserializer")
local Serializer = require("Bytecode.Serializer")

local Generate = require("VM.Generation")

local fs = require("Utils.fs")

return(function()
    local Code = fs.readFile("./Script.lua")
    local Bytecode = Compiler(Code, "NekoLuaAlpha")
    local Chunk = Deserializer(Bytecode)
    local SerializedBytecode = Serializer(Chunk)

    _G.UsedOps[0] = 0 -- closure
    _G.UsedOps[4] = 4 -- closure
    
    local VMOut = Generate(SerializedBytecode, _G.UsedOps)
    
    fs.writeFile("./Temp1.lua", VMOut)

    os.execute("node minify.js")

    print("Finished Obfuscation")
end)()