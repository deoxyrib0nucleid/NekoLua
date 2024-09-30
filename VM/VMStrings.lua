local Parts = {
    Variables = [=[
-- Generic Helpers
local LuaFunc, WrapState, BcToState, gChunk;
local FIELDS_PER_FLUSH = 50
local Select = select;

-- Array Helpers
local function CreateTbl(_) return {} end;
local Unpack = unpack or table.unpack
local function Pack(...)
    return {
        n = Select('#', ...), ...
    }
end
local function Move(src, First, Last, Offset, Dst)
    for i = _, Last - First do
        Dst[Offset + i] = src[First + i]
    end
end

-- Mini Bit Library
local function BAnd(a, b)
    local result = _
    local bitval = __
    while a > _ and b > _ do
        if (a % 2 == __) and (b % 2 == __) then
            result = result + bitval
        end
        bitval = bitval * 2
        a = math.floor(a / 2)
        b = math.floor(b / 2)
    end
    return result
end
local function LShift(x, n)
    return x * 2 ^ n
end
local function RShift(x, n)
    return math.floor(x / 2 ^ n)
end
local function BOr(a, b)
    local result = _
    local shift = __
    while a > _ or b > _ do
        local abit = a % 2
        local bbit = b % 2
        if abit == __ or bbit == __ then
            result = result + shift
        end
        a = math.floor(a / 2)
        b = math.floor(b / 2)
        shift = shift * 2
    end
    return result
end

-- Upvalue Helpers
local function CloseLuaUpvalues(List, Index)
    for i, uv in pairs(List) do
        if uv.Index >= Index then
            uv.Value = uv.Store[uv.Index];
            uv.Store = uv;
            uv.Index = 'Value'
            List[i] = nil;
        end;
    end;
end;

local function OpenLuaUpvalue(List, Index, Stack)
    local Prev = List[Index]

    if not Prev then
        Prev = { Index = Index, Store = Stack }
        List[Index] = Prev;
    end;

    return Prev;
end;
]=],
    Deserializer = [=[
function BcToState(Bytecode)
    local Pos = __
    
    local function gBits8()
        local Val = string.byte(Bytecode, Pos, Pos)
        Pos = Pos + __
        return Val;
    end;

    local function gBits16()
        local Val1, Val2 = string.byte(Bytecode, Pos, Pos + 2)
        Pos = Pos + 2;
        return (Val2 * 256) + Val1;
    end;

    local function gBits32()
        local Val1, Val2, Val3, Val4 = string.byte(Bytecode, Pos, Pos + 3)
        Pos = Pos + 4;
        return (Val4 * 16777216) + (Val3 * 65536) + (Val2 * 256) + Val1;
    end;

    local function gBits64()
        return gBits32() * 4294967296 + gBits32()
    end;

    local function gFloat()
        local Left = gBits32()
        local Right = gBits32()
        local IsNormal = __
        local Mantissa = BOr(LShift(BAnd(Right, 0xFFFFF), 32), Left);
        local Exponent  = BAnd(RShift(Right, 20), 0x7FF)
        local Sign = (-__) ^ RShift(Right, 31)

        if Exponent == _ then
            if Mantissa == _ then
                return Sign * _
            else
                Exponent = __
                IsNormal = _
            end;
        elseif Exponent == 2047 then
            if Mantissa == _ then
                return Sign * (__ / _)
            else
                return Sign * (_ / _)
            end;
        end;

        return math.ldexp(Sign, Exponent - 1023) * (IsNormal + (Mantissa / (2 ^ 52)))
    end;

    local function gString(Len)
		local Str;

		if Len then
			Str	= string.sub(Bytecode, Pos, Pos + Len - __);
			Pos = Pos + Len;
		else
			Len = gBits32();
			if (Len == _) then return; end;
			Str	= string.sub(Bytecode, Pos, Pos + Len - __);
			Pos = Pos + Len;
		end;

		return Str;
	end;

    function gChunk()
        local Chunk = {
            Upvals = gBits8(),
            Args = gBits8(),
            MaxStack = gBits8(),
            Instr = {},
            Const = {},
            Proto = {}
        }
        
        for i = __, gBits32() do
            local Data = gBits32()
            local Opco = gBits8()
            local Type = gBits8()
            local Inst = {
                Value = Data,
                Op = Opco,
                A = gBits16()
            }
            local Mode = {
                b = gBits8(),
                c = gBits8()
            }
            
            if (Type == __) then
                Inst.B = gBits16()
                Inst.C = gBits16()
                Inst.IsConstantB = Mode.b == __ and Inst.B > 0xFF
                Inst.IsConstantC = Mode.c == __ and Inst.C > 0xFF
            elseif (Type == 2) then
                Inst.Bx = gBits32()
                Inst.IsConstant = Mode.b == __
            elseif (Type == 3) then
                Inst.sBx = gBits32() - 131071
            end;

            Chunk.Instr[i] = Inst;
        end;

        for i = __, gBits32() do
            local Type = gBits8()

            if (Type == __) then
                Chunk.Const[i - __] = (gBits8() ~= _)
            elseif (Type == 3) then
                Chunk.Const[i - __] = gFloat()
            elseif (Type == 4) then
                Chunk.Const[i - __] = gString()
            end
        end;

        for i = __, gBits32() do
            Chunk.Proto[i - __] = gChunk()
        end

        -- post process optimization
        for _, v in ipairs(Chunk.Instr) do
            if v.IsConstant then
                v.Const = Chunk.Const[v.Bx]
            else
                if v.IsConstantB then
                    v.ConstB = Chunk.Const[v.B - 256]
                end;

                if v.IsConstantC then
                    v.ConstC = Chunk.Const[v.C - 256]
                end;
            end;
        end

        return Chunk
    end;

    return gChunk()
end;
]=],
    Wrapper_1 = [=[
function LuaFunc(State, Env, Upvals)
    local Instr = State.Instr;
    local Proto = State.Protos;
    local Vararg = State.Vararg;
    local Top = -__;
    local OpenList = {}
    local Stack = State.Stack;
    local Pc = State.Pc;

    while alpha do
        local Inst = Instr[Pc]
        local Op = Inst.Op;
        Pc = Pc + __;

]=],
    Wrapper_2 = [=[

        State.Pc = Pc;
    end;
end;

function WrapState(Proto, Env, Upval)
    local function Wrapped(...)
        local Passed = Pack(...)
        local Stack = CreateTbl(Proto.MaxStack)
        local Vararg = { Len = _, List = {} }
        
        Move(Passed, __, Proto.Args, _, Stack)

        if (Proto.Args < Passed.n) then
            local Start = Proto.Args + __
            local Len = Passed.n - Proto.Args;

            Vararg.Len = Len;
            Move(Passed, Start, Start + Len - __, __, Vararg.List)
        end;

        local State = {
            Vararg = Vararg,
            Stack = Stack,
            Instr = Proto.Instr,
            Protos = Proto.Proto,
            Pc = __
        }

        return LuaFunc(State, Env, Upval)
    end;

    return Wrapped;
end;
]=],
    DEBUGGER = [=[
local function log(...)
    local printValue
    local function printTable(t, indent)
        indent = indent or ""
        if type(t) ~= "table" then
            io.write(tostring(t))
            return
        end
        io.write("{\n")
        for k, v in pairs(t) do
            io.write(indent, "  ", tostring(k), ": ")
            if type(v) == "table" then
                printTable(v, indent .. "  ")
            else
                printValue(v)
            end
            io.write(",\n")
        end
        io.write(indent, "}")
    end

    printValue = function (value)
        if type(value) == "string" then
            io.write("\27[32m\"" .. tostring(value) .. "\"\27[0m")
        elseif type(value) == "number" then
            io.write("\27[33m" .. tostring(value) .. "\27[0m")
        else
            io.write(tostring(value))
        end
    end

    local args = {...}
    for i = __, #args do
        if type(args[i]) == "table" then
            printTable(args[i])
        else
            printValue(args[i])
        end
        if i < #args then
            io.write(" ")
        end
    end
    io.write("\n")
end    
]=]
}

return Parts