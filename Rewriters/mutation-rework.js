const luaparse = require('luaparse')
const luagen = require('luacodegen')
const fs = require('fs')

const func = (code) => {
    let ast = luaparse.parse(code, { scope: true }) // scope for globals

    function traverse(node) {
        if (!node) return;

        if (node && node.type && node.type === "NumericLiteral") {
            if (!node.Mutated) {
                let value = node && node.value;
                let big = Math.floor(Math.random() * 999999)
                let small = big - value
                node.raw = `(${Math.sign(big) === -1 ? "-0x" + (big).toString(16) : "0x" + (big).toString(16)} - ${Math.sign(small) === -1 ? "-0x" + (small * -1).toString(16) : "0x" + (small).toString(16) })`
                node.Mutated = true
            }
        }

        if (node && node.type && node.type === "BooleanLiteral") {
            if (!node.Mutated) {
                let shitIhaveTodo = [1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21]
                let Rand = shitIhaveTodo[(Math.floor(Math.random() * shitIhaveTodo.length))]

                let newRaw = ""

                for (let i = 0; i < Rand; i++) {
                    newRaw += "not "
                }

                if (node.value == true) {
                    node.raw = newRaw + "false"
                } else {
                    node.raw = newRaw + "not false"
                }
                node.Mutated = true
            }
        }

        if (typeof (node) == "object") {
            let Keys = Object.keys(node)
            for (let i = 0; i < Keys.length; i++) {
                traverse(node[Keys[i]])
            }
        }
    }

    traverse(ast)

    let Out = luagen(ast)

    // fs.writeFileSync("./test.lua", Out)

    return Out
}

func(`print(1 + 1)`)

module.exports = func