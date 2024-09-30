const luamin = require('luacodegen')
const { Beautify } = require('lua-format')
const luaparse = require('luaparse')
const fs = require('fs')

let visit = function(parentChunk, type, callback) {
    for (var i in parentChunk) {
        let currentChunk = parentChunk[i];

        if (typeof currentChunk != "object" || currentChunk == null) {
            continue;
        }

        if (currentChunk.type != null && currentChunk.type == type) {
            parentChunk[i] = callback(currentChunk) || currentChunk;  // Replace the node if a new one is returned
        }

        visit(currentChunk, type, callback);
    }
}

let memestrings = require('../components/memestrings.json')
const encoder = require('../../ext/xorAscii')

let func = (luaCode) => {
    let ast = luaparse.parse(luaCode, { scope: true })
    fs.writeFileSync("temp.json", JSON.stringify(ast, null, 4))

    //check if the number is even
    function isEven(number) {
        return number % 2 === 0;
    }

    //check if the number is odd
    function isOdd(number) {
        return number % 2 !== 0;
    }

    let numberMod = (node) => {
        let Rand = Math.floor(Math.random() * 3)
        // console.log(Rand)
        if (Rand == 0) { // arithmetic obfuscation
            let big = Math.random() * 999999
            let smol = big - node.value
            node.raw = `(${big} - ${smol})`
            node.value = node.value // reassigning
        } else if (Rand == 1) { // string length manipulation obfuscation
            let meme = memestrings[(Math.floor(Math.random() * memestrings.length))]
            let big = `#[[${meme}]]`
            let smol = meme.length - node.value
            node.raw = `(${big} - ${smol})`
            node.value = node.value // reassigning
        } else { // func manipulation
            let meme = memestrings[(Math.floor(Math.random() * memestrings.length))]
            let big = Math.random() * 999999
            let smol = big - node.value

            let patterns = [
                `(function(a,b,c) return a + -b, c end)(${big}, ${smol}, [[${meme}]])`,
                `(function(a,b) return a + -b end)(${big}, ${smol})`,
            ]

            let selected = patterns[(Math.floor(Math.random() * patterns.length))]

            // console.log(selected)

            node.raw = selected
        }
    }

    let booleanMod = (node) => {
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
    }

    let Iterations = Math.floor(Math.random() * 2) + 1

    let Map = [
        () => { visit(ast, "NumericLiteral", numberMod) },
        () => { visit(ast, "BooleanLiteral", booleanMod) },
    ]

    for (let i = 0; i < Iterations; i++) {
        for (let i of Map) {
            i()
        }
    }

    let out = luamin(ast)
    // let out = Beautify(luamin.minify(ast), { RenameVariables: false, RenameGlobals: false, SolveMath: false })

    return out
}

// fs.writeFileSync("scriptz.lua", func(`
// a = false
// print(a)
// `))

module.exports = func