local VMStrings = require("VM.VMStrings")
local GetOpcodeCode = require("VM.Opcodes")

local function Generate(...)
    local Data = {...}
    local Bytecode = Data[1]
    local UsedOpcodes = Data[2]

    local Out = ""

    local function Add(Code)
        Out = Out .. "\n" .. Code;
    end;

    local function GenerateVariable(length)
        local charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        local result = {}
        
        math.randomseed(os.clock()^math.random(2,5))
    
        for i = 1, length do
            local rand = math.random(1, #charset)
            table.insert(result, charset:sub(rand, rand))
        end
    
        return table.concat(result)
    end

    local function Encode(Str)
        local out = ""

        for i = 1, #Str do
            out = out .. "\\" .. string.byte(Str, i)
        end

        return out;
    end;

    -- Add(VMStrings.DEBUGGER)

    Add("nekolua,v1,alpha,__,_ = 'This file was protected by NekoLua Alpha 1.0 at deoxyrib0nucleid', function()end, true, 1, 0")
    Add(VMStrings.Variables)
    Add(VMStrings.Deserializer)
    Add(VMStrings.Wrapper_1)

    local k = "if"
    for i, v in pairs(UsedOpcodes) do
        local Op = UsedOpcodes[v]
        Add(k.." (Op == " .. Op .. ") then\n")
        Add(GetOpcodeCode(Op))
        k = "elseif"
    end
    Add("end")

    -- local function GetStr(opcodes) -- do not enable, this sucks ass
    --     local str = ""
    
    --     if #opcodes == 1 then
    --         str = GetOpcodeCode(opcodes[1])  -- Only one opcode
    --     elseif #opcodes == 2 then
    --         if math.random(2) == 1 then
    --             str = "if Op > " .. opcodes[1] .. " then\n" .. GetOpcodeCode(opcodes[2])
    --             str = str .. " else\n" .. GetOpcodeCode(opcodes[1]) .. " end;"
    --         else
    --             str = "if Op == " .. opcodes[1] .. " then\n" .. GetOpcodeCode(opcodes[1])
    --             str = str .. " else\n" .. GetOpcodeCode(opcodes[2]) .. " end;"
    --         end
    --     else
    --         table.sort(opcodes)
    --         local mid = math.ceil(#opcodes / 2)
    --         local left = {table.unpack(opcodes, 1, mid)}
    --         local right = {table.unpack(opcodes, mid + 1)}
    
    --         str = "if Op <= " .. left[#left] .. " then\n"
    --         str = str .. GetStr(left)
    --         str = str .. " else\n"
    --         str = str .. GetStr(right)
    --         str = str .. " end;"
    --     end
    
    --     return str
    -- end

    -- local Ordered = {}
    -- for _, v in pairs(UsedOpcodes) do
    --     table.insert(Ordered, UsedOpcodes[v])
    -- end
    -- Add("if Op <= " .. Ordered[#Ordered] .. " then")
    -- Add(GetStr(Ordered))
    -- Add("end")

    Add(VMStrings.Wrapper_2)
    Add("WrapState(BcToState('".. Encode(Bytecode) .. "'), getfenv(0))()")

    -- Add(VMStrings.DEBUGGER)
    -- Add("log(BcToState('".. Encode(Bytecode) .. "'))")

    return Out;
end

return Generate