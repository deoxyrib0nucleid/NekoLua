-- This script was made by OxidaneDev
-- Copyright 2024 @OxidaneDev
-- Benchmark.lua
-- A benchmark testing that tests Lua's performance (5.1)

_G.Iterations = 10000 -- Recommended max iterations

print("NEKO LUA BENCHMARK (orion benchmark aka my benchmark project lel)")
print("-------------------------[[ o r I o n - b e n c H m a r k ]]-------------------------")
print("-------------------------[[              v1.0             ]]-------------------------")
print("-------------------------[[        Preloading Assets      ]]-------------------------")

local OFFICIAL_START_TIME = os.clock()

local FINAL_RATING = {
    ["Perfect"] = { Min = -math.huge, Max = 0 },
    ["S"] = { Min = 0, Max = 0.4 },
    ["A"] = { Min = 0.5, Max = 0.9 },
    ["B"] = { Min = 1, Max = 4 },
    ["C"] = { Min = 5, Max = 9 },
    ["D"] = { Min = 10, Max = 19 },
    ["F"] = { Min = 20, Max = 49 },
    ["Trash"] = { Min = 50, Max = math.huge }
}

local function GetRating(TimeTook)
    local ReturnedRating;

    for i, v in pairs(FINAL_RATING) do
        if (v.Min <= TimeTook) and (v.Max >= TimeTook) then
            ReturnedRating = i
        end
    end

    return ReturnedRating
end

-- Opcode table with benchmark tests
local OPCODES = {
    [0] = function() -- MOVE
        local DArr, DArr2 = { 1 }, {}
        local StartTime = os.clock()

        for i = 1, _G.Iterations do
            DArr[1] = DArr2[2]
            DArr = DArr
        end

        local TimeTook = os.clock() - StartTime
        return { [1] = TimeTook, [2] = GetRating(TimeTook) }
    end,
    [1] = function() -- LOADK
        local DArr;
        local StartTime = os.clock()

        for i = 1, _G.Iterations do
            DArr = "o r I o n"
        end

        local TimeTook = os.clock() - StartTime
        return { [1] = TimeTook, [2] = GetRating(TimeTook) }
    end,
    [2] = function() -- LOADBOOL
        local DArr, DArr2;
        local StartTime = os.clock()

        for i = 1, _G.Iterations do
            DArr = true
            DArr2 = false
            DArr = false
            DArr2 = true
        end

        local TimeTook = os.clock() - StartTime
        return { [1] = TimeTook, [2] = GetRating(TimeTook) }
    end,
    [3] = function() -- LOADNIL
        local DArr;
        local StartTime = os.clock()

        for i = 1, _G.Iterations do
            DArr = nil
        end

        local TimeTook = os.clock() - StartTime
        return { [1] = TimeTook, [2] = GetRating(TimeTook) }
    end,
    [4] = function() -- GETUPVAL
        local DArr;
        local DArr2 = function() end;
        local StartTime = os.clock()

        for i = 1, _G.Iterations do
            (function()
                DArr = DArr2()
            end)()
        end

        local TimeTook = os.clock() - StartTime
        return { [1] = TimeTook, [2] = GetRating(TimeTook) }
    end,
    [5] = function() -- GETGLOBAL
        local DArr
        local StartTime = os.clock()

        for i = 1, _G.Iterations do
            DArr = _G.Iterations -- technically global
        end

        local TimeTook = os.clock() - StartTime
        return { [1] = TimeTook, [2] = GetRating(TimeTook) }
    end,
    [6] = function() -- GETTABLE
        local DArr;
        local DArr2 = {};
        local StartTime = os.clock()

        for i = 1, _G.Iterations do
            DArr = DArr2[i]
        end

        local TimeTook = os.clock() - StartTime
        return { [1] = TimeTook, [2] = GetRating(TimeTook) }
    end,
    [7] = function() -- SETGLOBAL
        DArr = ""
        local StartTime = os.clock()

        for i = 1, _G.Iterations do
            DArr = "" .. i .. ""
        end

        local TimeTook = os.clock() - StartTime
        return { [1] = TimeTook, [2] = GetRating(TimeTook) }
    end,
    [8] = function() -- SETUPVAL
        local DArr;
        local DArr2 = function() end;
        local StartTime = os.clock()

        for i = 1, _G.Iterations do
            DArr2 = DArr;
        end

        local TimeTook = os.clock() - StartTime
        return { [1] = TimeTook, [2] = GetRating(TimeTook) }
    end,
    [9] = function() -- SETTABLE
        local DArr = {}
        local StartTime = os.clock()

        for i = 1, _G.Iterations do
            DArr[i] = math.random(1, 5)
        end

        local TimeTook = os.clock() - StartTime
        return { [1] = TimeTook, [2] = GetRating(TimeTook) }
    end,
    [10] = function() -- NEWTABLE
        local DArr;
        local StartTime = os.clock()

        for i = 1, _G.Iterations do
            DArr = {}
        end

        local TimeTook = os.clock() - StartTime
        return { [1] = TimeTook, [2] = GetRating(TimeTook) }
    end,
    [11] = function() -- SELF
        local DArr = {}
        DArr.__index = DArr;

        function DArr.new()
            local self = setmetatable({ ["Hello"] = "Orion" }, DArr)
            return self
        end

        function DArr:DFunc()
            self["Hello"] = "World"
        end

        local StartTime = os.clock()

        for i = 1, _G.Iterations do
            DArr.new():DFunc()
        end

        local TimeTook = os.clock() - StartTime
        return { [1] = TimeTook, [2] = GetRating(TimeTook) }
    end,
    [12] = function() -- ADD
        local DArr, DArr2 = math.random(1, 5), math.random(1, 5)
        local StartTime = os.clock()

        for i = 1, _G.Iterations do
            DArr = DArr + DArr2 + i
        end

        local TimeTook = os.clock() - StartTime
        return { [1] = TimeTook, [2] = GetRating(TimeTook) }
    end,
    [13] = function() -- SUB
        local DArr, DArr2 = math.random(1, 5), math.random(1, 5)
        local StartTime = os.clock()

        for i = 1, _G.Iterations do
            DArr = DArr - DArr2 - i
        end

        local TimeTook = os.clock() - StartTime
        return { [1] = TimeTook, [2] = GetRating(TimeTook) }
    end,
    [14] = function() -- MUL
        local DArr, DArr2 = math.random(1, 5), math.random(1, 5)
        local StartTime = os.clock()

        for i = 1, _G.Iterations do
            DArr = DArr * DArr2 * i
        end

        local TimeTook = os.clock() - StartTime
        return { [1] = TimeTook, [2] = GetRating(TimeTook) }
    end,
    [15] = function() -- DIV
        local DArr, DArr2 = math.random(1, 5), math.random(1, 5)
        local StartTime = os.clock()

        for i = 1, _G.Iterations do
            DArr = DArr / DArr2 / i
        end

        local TimeTook = os.clock() - StartTime
        return { [1] = TimeTook, [2] = GetRating(TimeTook) }
    end,
    [16] = function() -- MOD
        local DArr, DArr2 = math.random(1, 5), math.random(1, 5)
        local StartTime = os.clock()

        for i = 1, _G.Iterations do
            DArr = DArr % DArr2 % i
        end

        local TimeTook = os.clock() - StartTime
        return { [1] = TimeTook, [2] = GetRating(TimeTook) }
    end,
    [17] = function() -- POW
        local DArr, DArr2 = math.random(1, 5), math.random(1, 5)
        local StartTime = os.clock()

        for i = 1, _G.Iterations do
            DArr = DArr ^ DArr2 ^ i
        end

        local TimeTook = os.clock() - StartTime
        return { [1] = TimeTook, [2] = GetRating(TimeTook) }
    end,
    [18] = function() -- UNM
        local DArr = math.random(1, 5)
        local StartTime = os.clock()

        for i = 1, _G.Iterations do
            DArr = -DArr
        end

        local TimeTook = os.clock() - StartTime
        return { [1] = TimeTook, [2] = GetRating(TimeTook) }
    end,
    [19] = function() -- NOT
        local DArr = true
        local StartTime = os.clock()

        for i = 1, _G.Iterations do
            DArr = not DArr
        end

        local TimeTook = os.clock() - StartTime
        return { [1] = TimeTook, [2] = GetRating(TimeTook) }
    end,
    [20] = function() -- LEN
        local DArr;
        local DArr2 = "" .. math.random(1, 100) .. ""
        local StartTime = os.clock()

        for i = 1, _G.Iterations do
            DArr = #DArr2
        end

        local TimeTook = os.clock() - StartTime
        return { [1] = TimeTook, [2] = GetRating(TimeTook) }
    end,
    [21] = function() -- CONCAT
        local DArr, DArr2 = "Hello, ", "World"
        local StartTime = os.clock()

        for i = 1, _G.Iterations do
            DArr = DArr .. DArr2
        end

        local TimeTook = os.clock() - StartTime
        return { [1] = TimeTook, [2] = GetRating(TimeTook) }
    end,
    [22] = function() -- JMP
        local StartTime = os.clock()

        for i = 1, _G.Iterations do
            for i2 = 1, _G.Iterations do
                i2 = i2
                break;
            end
        end

        local TimeTook = os.clock() - StartTime
        return { [1] = TimeTook, [2] = GetRating(TimeTook) }
    end,
    [23] = function() -- EQ
        local DArr = true
        local StartTime = os.clock()

        for i = 1, _G.Iterations do
            if DArr == DArr then
                i = i
            end
        end

        local TimeTook = os.clock() - StartTime
        return { [1] = TimeTook, [2] = GetRating(TimeTook) }
    end,
    [24] = function() -- LT
        local DArr, DArr2 = 1, 2
        local StartTime = os.clock()

        for i = 1, _G.Iterations do
            if (DArr < DArr2) then
                i = i
            end
        end

        local TimeTook = os.clock() - StartTime
        return { [1] = TimeTook, [2] = GetRating(TimeTook) }
    end,
    [25] = function() -- LE
        local DArr, DArr2 = 1, 1
        local StartTime = os.clock()

        for i = 1, _G.Iterations do
            if (DArr <= DArr2) then
                i = i
            end
        end

        local TimeTook = os.clock() - StartTime
        return { [1] = TimeTook, [2] = GetRating(TimeTook) }
    end,
    [26] = function() -- TEST
        local StartTime = os.clock()

        for i = 1, _G.Iterations do
            if false then
                i = i
            end
        end

        local TimeTook = os.clock() - StartTime
        return { [1] = TimeTook, [2] = GetRating(TimeTook) }
    end,
    [27] = function() -- TESTSET
        local function DArr(A) end;
        local StartTime = os.clock()

        for i = 1, _G.Iterations do
            DArr(i == i or false)
        end

        local TimeTook = os.clock() - StartTime
        return { [1] = TimeTook, [2] = GetRating(TimeTook) }
    end,
    [28] = function() -- CALL
        local function DArr(A) end;
        local StartTime = os.clock()

        for i = 1, _G.Iterations do
            DArr(math.random(1, 5))
        end

        local TimeTook = os.clock() - StartTime
        return { [1] = TimeTook, [2] = GetRating(TimeTook) }
    end,
    [29] = function() -- TAILCALL
        local DArr = function(A) end
        local StartTime = os.clock()

        for i = 1, _G.Iterations do
            (function()
                return DArr()
            end)()
        end

        local TimeTook = os.clock() - StartTime
        return { [1] = TimeTook, [2] = GetRating(TimeTook) }
    end,
    [30] = function() -- RETURN
        local StartTime = os.clock()
        local TimeTook;

        for i = 1, _G.Iterations do
            -- TODO: 
        end

        TimeTook = os.clock() - StartTime
        return { [1] = TimeTook, [2] = GetRating(TimeTook) }
    end,
    [31] = function() -- FORLOOP
        local StartTime = os.clock()

        for i = 1, _G.Iterations do
            for k = i, i do
                i = i
            end
        end

        local TimeTook = os.clock() - StartTime
        return { [1] = TimeTook, [2] = GetRating(TimeTook) }
    end,
    [32] = function() -- FORPREP
        local DArr, DArr2 = {}, {}
        local StartTime = os.clock()

        for i = 1, _G.Iterations do
            for k = i, 0 do
                i = i -- this will never happen
            end
        end

        local TimeTook = os.clock() - StartTime
        return { [1] = TimeTook, [2] = GetRating(TimeTook) }
    end,
    [33] = function() -- TFORLOOP
        local DArr, next = {}, next
        local StartTime = os.clock()

        for i = 1, _G.Iterations do
            for k, v in next, DArr do
                i = i
            end
        end

        local TimeTook = os.clock() - StartTime
        return { [1] = TimeTook, [2] = GetRating(TimeTook) }
    end,
    [34] = function() -- SETLIST
        local NDArr;
        local DArr, DArr2 = function(...) NDArr = { ... } end, {}
        local StartTime = os.clock()

        for i = 1, _G.Iterations do
            DArr2[i] = NDArr
        end

        local TimeTook = os.clock() - StartTime
        return { [1] = TimeTook, [2] = GetRating(TimeTook) }
    end,
    [35] = function() -- CLOSE
        local StartTime = os.clock()

        for i = 1, _G.Iterations do
            io.stderr:flush()
        end

        local TimeTook = os.clock() - StartTime
        return { [1] = TimeTook, [2] = GetRating(TimeTook) }
    end,
    [36] = function() -- CLOSURE
        local DArr
        local StartTime = os.clock()

        for i = 1, _G.Iterations do
            DArr = function() end
            DArr() -- useless call
        end

        local TimeTook = os.clock() - StartTime
        return { [1] = TimeTook, [2] = GetRating(TimeTook) }
    end,
    [37] = function() -- VARARG
        local NDArr;
        local DArr = function(...) NDArr = ({...})[1] end
        local StartTime = os.clock()

        for i = 1, _G.Iterations do
            DArr("Hello-Orion", 1, 2, 3)
        end

        local TimeTook = os.clock() - StartTime
        return { [1] = TimeTook, [2] = GetRating(TimeTook) }
    end
}

print("-------------------------[[           Starting            ]]-------------------------")

-- Begin Benchmark
local OUT = { "-------------------------[[             RESULTS           ]]-------------------------" }

for i, v in pairs(OPCODES) do
    local Called = v() -- Call the opcode function and get results
    local TimeTook, FinalRating = Called[1], Called[2]

    -- Append the results for each opcode
    OUT[#OUT + 1] = string.format("\tOPCODE: %d\t\tTIME TOOK: %.2f\t\tRATING: %s", i, TimeTook, FinalRating)
end

local OFFICIAL_END_TIME = os.clock() - OFFICIAL_START_TIME

-- Append final time and overall rating
OUT[#OUT + 1] = "-------------------------------------------------------------------------------------"
OUT[#OUT + 1] = string.format("\n\tFinished in %.2f seconds | RATING OVERALL: %s\n", OFFICIAL_END_TIME, GetRating(OFFICIAL_END_TIME))
OUT[#OUT + 1] = "-------------------------------------------------------------------------------------"

-- Output results
print(table.concat(OUT, "\n"))