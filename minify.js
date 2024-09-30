const flatten1 = require("./Rewriters/flatten-rework")
const flatten2 = require("./Rewriters/vanilla/vanilla-flatten")
const mutate = require("./Rewriters/mutation-rework")
const { Beautify, Minify } = require("lua-format")
const fs = require('fs')

const outcode = fs.readFileSync("./Temp1.lua", "utf-8")
let out = ''
out = flatten2(out)
out = flatten1(outcode)
out = mutate(out)
out = Minify(out, { RenameVariables: true, RenameGlobals: false, SolveMath: false })

fs.writeFileSync("./Output.lua", out)
fs.unlinkSync("./Temp1.lua")