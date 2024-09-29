local function GetOpcodeCode(Op)
    if (Op == 0) then
        return [=[Stack[Inst.A] = Stack[Inst.B];]=]
    elseif (Op == 1) then
        return [=[Stack[Inst.A] = Inst.Const]=]
    elseif (Op == 2) then
        return [=[
        Stack[Inst.A] = Inst.B ~= 0

        if Inst.C ~= 0 then Pc = Pc + 1 end;
        ]=]
    elseif (Op == 3) then
        return [=[
        for i = Inst.A, Inst.B do Stack[i] = nil end;
        ]=]
    elseif (Op == 4) then
        return [=[
        local Uv = Upvals[Inst.B]
        Stack[Inst.A] = Uv.Store[Uv.Index]
        ]=]
    elseif (Op == 5) then
        return [=[
        Stack[Inst.A] = Env[Inst.Const]
        ]=]
    elseif (Op == 6) then
        return [=[
        local Index

        if Inst.IsConstantC then
            Index = Inst.ConstC;
        else
            Index = Stack[Inst.C]
        end

        Stack[Inst.A] = Stack[Inst.B][Index]
        ]=]
    elseif (Op == 7) then
        return [=[
        Env[Inst.Const] = Stack[Inst.A]
        ]=]
    elseif (Op == 8) then
        return [=[
        local Uv = Upvals[Inst.B]
        Uv.Store[Uv.Index] = Stack[Inst.A]
        ]=]
    elseif (Op == 9) then
        return [=[
        local Index, Value

        if Inst.IsConstantB then
            Index = Inst.ConstB
        else
            Index = Stack[Inst.B]
        end

        if Inst.IsConstantC then
            Value = Inst.ConstC
        else
            Value = Stack[Inst.C]
        end

        Stack[Inst.A][Index] = Value
        ]=]
    elseif (Op == 10) then
        return [=[
        Stack[Inst.A] = {}
        ]=]
    elseif (Op == 11) then
        return [=[
        local A = Inst.A
        local B = Inst.B
        local Index;

        if Inst.IsConstantC then
            Index = Inst.ConstC
        else
            Index = Stack[Inst.C]
        end

        Stack[A + 1] = Stack[B]
        Stack[A] = Stack[B][Index]
        ]=]
    elseif (Op == 12) then
        return [=[
        local Lhs, Rhs;

        if Inst.IsConstantB then
            Lhs = Inst.ConstB
        else
            Lhs = Stack[Inst.B]
        end

        if Inst.IsConstantC then
            Rhs = Inst.ConstC
        else
            Rhs = Stack[Inst.C]
        end

        Stack[Inst.A] = Lhs + Rhs
        ]=]
    elseif (Op == 13) then
        return [=[
        local Lhs, Rhs;

        if Inst.IsConstantB then
            Lhs = Inst.ConstB
        else
            Lhs = Stack[Inst.B]
        end

        if Inst.IsConstantC then
            Rhs = Inst.ConstC
        else
            Rhs = Stack[Inst.C]
        end

        Stack[Inst.A] = Lhs - Rhs
        ]=]
    elseif (Op == 14) then
        return [=[
        local Lhs, Rhs;

        if Inst.IsConstantB then
            Lhs = Inst.ConstB
        else
            Lhs = Stack[Inst.B]
        end

        if Inst.IsConstantC then
            Rhs = Inst.ConstC
        else
            Rhs = Stack[Inst.C]
        end

        Stack[Inst.A] = Lhs * Rhs
        ]=]
    elseif (Op == 15) then
        return [=[
        local Lhs, Rhs;

        if Inst.IsConstantB then
            Lhs = Inst.ConstB
        else
            Lhs = Stack[Inst.B]
        end

        if Inst.IsConstantC then
            Rhs = Inst.ConstC
        else
            Rhs = Stack[Inst.C]
        end

        Stack[Inst.A] = Lhs / Rhs
        ]=]
    elseif (Op == 16) then
        return [=[
        local Lhs, Rhs;

        if Inst.IsConstantB then
            Lhs = Inst.ConstB
        else
            Lhs = Stack[Inst.B]
        end

        if Inst.IsConstantC then
            Rhs = Inst.ConstC
        else
            Rhs = Stack[Inst.C]
        end

        Stack[Inst.A] = Lhs % Rhs
        ]=]
    elseif (Op == 17) then
        return [=[
        local Lhs, Rhs;

        if Inst.IsConstantB then
            Lhs = Inst.ConstB
        else
            Lhs = Stack[Inst.B]
        end

        if Inst.IsConstantC then
            Rhs = Inst.ConstC
        else
            Rhs = Stack[Inst.C]
        end

        Stack[Inst.A] = Lhs ^ Rhs
        ]=]
    elseif (Op == 18) then
        return [=[
        Stack[Inst.A] = -Stack[Inst.B]
        ]=]
    elseif (Op == 19) then
        return [=[
        Stack[Inst.A] = not Stack[Inst.B]
        ]=]
    elseif (Op == 20) then
        return [=[Stack[Inst.A] = #Stack[Inst.B]]=]
    elseif (Op == 21) then
        return [=[
        local B, C = Inst.B, Inst.C;
        local Success, Str = pcall(table.concat, Stack, "", B, C)

        if not Success then
            Str = Stack[B] or ""
            for i = B + 1, C do Str = Str .. (Stack[i] or Stack[i - 1]) end;
        end;

        Stack[Inst.A] = Str;
        ]=]
    elseif (Op == 22) then
        return [=[Pc = Pc + Inst.sBx]=]
    elseif (Op == 23) then
        return [=[
        local Lhs, Rhs;

        if Inst.IsConstantB then
            Lhs = Inst.ConstB
        else
            Lhs = Stack[Inst.B]
        end

        if Inst.IsConstantC then
            Rhs = Inst.ConstC
        else
            Rhs = Stack[Inst.C]
        end

        if (Lhs == Rhs) == (Inst.A ~= 0) then Pc = Pc + Instr[Pc].sBx end;

        Pc = Pc + 1
        ]=]
    elseif (Op == 24) then
        return [=[
        local Lhs, Rhs;

        if Inst.IsConstantB then
            Lhs = Inst.ConstB
        else
            Lhs = Stack[Inst.B]
        end

        if Inst.IsConstantC then
            Rhs = Inst.ConstC
        else
            Rhs = Stack[Inst.C]
        end

        if (Lhs < Rhs) == (Inst.A ~= 0) then Pc = Pc + Instr[Pc].sBx end;

        Pc = Pc + 1
        ]=]
    elseif (Op == 25) then
        return [=[
        local Lhs, Rhs;

        if Inst.IsConstantB then
            Lhs = Inst.ConstB
        else
            Lhs = Stack[Inst.B]
        end

        if Inst.IsConstantC then
            Rhs = Inst.ConstC
        else
            Rhs = Stack[Inst.C]
        end

        if (Lhs <= Rhs) == (Inst.A ~= 0) then Pc = Pc + Instr[Pc].sBx end;

        Pc = Pc + 1
        ]=]
    elseif (Op == 26) then
        return [=[
        if (not Stack[Inst.A]) ~= (Inst.C ~= 0) then Pc = Pc + Instr[Pc].sBx end
        Pc = Pc + 1
        ]=]
    elseif (Op == 27) then
        return [=[
        local A = Inst.A
        local B = Inst.B;

        if (not Stack[B]) ~= (Inst.C ~= 0) then
            Stack[A] = Stack[B]
            Pc = Pc + Instr[Pc].sBx
        end;

        Pc = Pc + 1
        ]=]
    elseif (Op == 28) then
        return [=[
        local A = Inst.A;
        local B = Inst.B;
        local C = Inst.C;
        local Params;

        if B == 0 then
            Params = Top - A;
        else
            Params = B - 1;
        end;

        local RetList = Pack(Stack[A](Unpack(Stack, A + 1, A + Params)))
        local RetNum = RetList.n;

        if C == 0 then
            Top = A + RetNum - 1;
        else
            RetNum = C - 1;
        end;

        Move(RetList, 1, RetNum, A, Stack)
        ]=]
    elseif (Op == 29) then
        return [=[
        local A = Inst.A;
        local B = Inst.B;
        local Params;
        
        if B == 0 then
            Params = Top - A;
        else
            Params = B - 1;
        end;

        CloseLuaUpvalues(OpenList, 0)

        return Stack[A](Unpack(Stack, A + 1, A + Params))
        ]=]
    elseif (Op == 30) then
        return [=[
        local A = Inst.A;
        local B = Inst.B;
        local Len;
        
        if B == 0 then
            Len = Top - A + 1;
        else
            Len = B - 1;
        end;

        CloseLuaUpvalues(OpenList, 0)

        return Unpack(Stack, A, A + Len - 1)
        ]=]
    elseif (Op == 31) then
        return [=[
        local A = Inst.A;
        local Step = Stack[A + 2]
        local Index = Stack[A] + Step;
        local Limit = Stack[A + 1]
        local Loops

        if Step == math.abs(Step) then
            Loops = Index <= Limit;
        else
            Loops = Index >= Limit;
        end;

        if Loops then
            Stack[A] = Index;
            Stack[A + 3] = Index;
            Pc = Pc + Inst.sBx;
        end;
        ]=]
    elseif (Op == 32) then
        return [=[
        local A = Inst.A;
        local Init, Limit, Step;

        Init = tonumber(Stack[A])
        Limit = tonumber(Stack[A + 1])
        Step = tonumber(Stack[A + 2])

        Stack[A] = Init - Step;
        Stack[A + 1] = Limit;
        Stack[A + 2] = Step;

        Pc = Pc + Inst.sBx;
        ]=]
    elseif (Op == 33) then
        return [=[
        local A = Inst.A;
        local Base = A + 3;
        local Vals = {Stack[A](Stack[A + 1], Stack[A + 2])}

        Move(Vals, 1, Inst.C, Base, Stack)

        if Stack[Base] ~= nil then
            Stack[A + 2] = Stack[Base]
            Pc = Pc + Instr[Pc].sBx;
        end;

        Pc = Pc + 1
        ]=]
    elseif (Op == 34) then
        return [=[
        local A = Inst.A
        local C = Inst.C
        local Len = Inst.B;
        local Tab = Stack[A]
        local Offset;

        if Len == 0 then Len = Top - A end

        if C == 0 then
            C = Instr[Pc].Value; -- idk why
            Pc = Pc + 1
        end;

        Offset = (C - 1) * FIELDS_PER_FLUSH

        Move(Stack, A + 1, A + Len, Offset + 1, Tab)
        ]=]
    elseif (Op == 35) then
        return [=[CloseLuaUpvalues(OpenList, Inst.A)]=]
    elseif (Op == 36) then
        return [=[
        local Sub = Proto[Inst.Bx]
        local Nups = Sub.Upvals;
        local UvList;

        if Nups ~= 0 then
            UvList = CreateTbl(Nups - 1)

            for i = 1, Nups do
                local Pseudo = Instr[Pc + i - 1]

                if (Pseudo.Op == 0) then
                    UvList[i - 1] = OpenLuaUpvalue(OpenList, Pseudo.B, Stack)
                elseif (Pseudo.Op == 4) then
                    UvList[i - 1] = Upvals[Pseudo.B]
                end;
            end;

            Pc = Pc + Nups
        end;

        Stack[Inst.A] = WrapState(Sub, Env, UvList)
        ]=]
    elseif (Op == 37) then
        return [=[
        local A = Inst.A;
        local Len = Inst.B;

        if (Len == 0) then
            Len = Vararg.Len;
            Top = A + Len - 1;
        end;

        Move(Vararg.List, 1, Len, A, Stack)
        ]=]
    end
end;

return GetOpcodeCode