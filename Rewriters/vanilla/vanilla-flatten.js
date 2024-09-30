const luaparse = require('luaparse');
const luamin = require('luacodegen');
const { Beautify } = require('lua-format')
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
const fs = require('fs')

let func = (luaCode) => {
    let ast = luaparse.parse(luaCode, { scope: true });
    // fs.writeFileSync("temp.json", JSON.stringify(ast, null, 4))

    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';

    function generateVariable(length) {
        let result = ' ';
        const charactersLength = characters.length;
        for (let i = 0; i < length; i++) {
            result += characters.charAt(Math.floor(Math.random() * charactersLength));
        }

        return result;
    }

    function shuffle(array) {
        let currentIndex = array.length;

        // While there remain elements to shuffle...
        while (currentIndex != 0) {

            // Pick a remaining element...
            let randomIndex = Math.floor(Math.random() * currentIndex);
            currentIndex--;

            // And swap it with the current element.
            [array[currentIndex], array[randomIndex]] = [
                array[randomIndex], array[currentIndex]];
        }
    }

    let IfThenClauseMod = (node) => {
        let body = node.body

        let val = Math.floor(Math.random() * 5000000)
        let val2 = Math.floor(Math.random() * 5000000)

        let var1 = generateVariable(16)
        let var2 = generateVariable(16)

        let newBody = [
            {
                "type": "LocalStatement",
                "variables": [
                    {
                        "type": "Identifier",
                        "name": var1,
                        "isLocal": true
                    },
                    {
                        "type": "Identifier",
                        "name": var2,
                        "isLocal": true
                    },
                ],
                "init": [
                    {
                        "type": "NumericLiteral",
                        "value": val,
                        "raw": `${val}`
                    },
                    {
                        "type": "NumericLiteral",
                        "value": val2,
                        "raw": `${val2}`
                    }
                ]
            },
            {
                "type": "WhileStatement",
                "condition": {
                    "type": "BinaryExpression",
                    "operator": val > val2 ? ">" : "<",
                    "left": {
                        "type": "Identifier",
                        "name": var1,
                        "isLocal": true
                    },
                    "right": {
                        "type": "Identifier",
                        "name": var2,
                        "isLocal": true
                    }
                },
                "body": body
            }
        ]

        let isReturn = false

        if (node.body.length != 0) {
            if (node.body[node.body.length - 1].type == "ReturnStatement") {
                isReturn = true;
            } else {
                isReturn = false
            }
        }

        if (isReturn == true) {
            newBody[1].body.unshift({
                "type": "AssignmentStatement",
                "variables": [
                    {
                        "type": "Identifier",
                        "name": var2,
                        "isLocal": true
                    }
                ],
                "init": [
                    {
                        "type": "NumericLiteral",
                        "raw": `${(val > val2 ? val2 * val - 5000 : val2 - val * 50)}`
                    }
                ]
            })
        } else {
            newBody = body
        }

        node.body = newBody
    }

    let WhileThenClauseMod = (node) => {
        let condition = node.condition;
        if (condition.type == "BooleanLiteral") {
            if (condition.raw == "true") {
                condition.raw == "not false"
            } else {
                condition.raw == "not not false"
            }
        }

        let val = Math.floor(Math.random() * 5000000)
        let val2 = Math.floor(Math.random() * 5000000)
        
        let var1 = generateVariable(16)
        let var2 = generateVariable(16)

        let body = node.body;
        let newBody = [
            {
                "type": "LocalStatement",
                "variables": [
                    {
                        "type": "Identifier",
                        "name": var1,
                        "isLocal": true
                    }
                ],
                "init": [
                    {
                        "type": "NumericLiteral",
                        "value": val,
                        "raw": `${val}`
                    }
                ]
            },
            {
                "type": "LocalStatement",
                "variables": [
                    {
                        "type": "Identifier",
                        "name": var2,
                        "isLocal": true
                    }
                ],
                "init": [
                    {
                        "type": "NumericLiteral",
                        "value": val2,
                        "raw": `${val2}`
                    }
                ]
            },
            {
                "type": "IfStatement",
                "clauses": [
                    {
                        "type": "IfClause",
                        "condition": {
                            "type": "BinaryExpression",
                            "operator": val > val2 ? ">" : "<",
                            "left": {
                                "type": "Identifier",
                                "name": var1,
                                "isLocal": true
                            },
                            "right": {
                                "type": "Identifier",
                                "name": var2,
                                "isLocal": true
                            },
                        },
                        "body": body
                    }
                ]
            }
        ]

        node.body = newBody
    }

    let Map = [
        () => { visit(ast, "WhileStatement", WhileThenClauseMod) },
        () => { visit(ast, "IfClause", IfThenClauseMod) },
        () => { visit(ast, "ElseClause", IfThenClauseMod) },
        () => { visit(ast, "ElseifClause", IfThenClauseMod) }
    ]

    shuffle(Map)
    // console.log(`SHUFFLED: ${Map}`)

    let Iterations = Math.floor(Math.random() * 2) + 1

    for (let i = 0; i < Iterations; i++) {
        for (let i of Map) {
            i()
        }
    }

    let out = luamin(ast)
    // console.log(JSON.stringify(ast, null, 2))
    // fs.writeFileSync("test.lua", out) // minify
    // fs.writeFileSync("test.lua", Beautify(out, {RenameVariables: false, RenameGlobals: false, SolveMath: false})) // beautify
    return out
}

module.exports = func