const luaparse = require('luaparse')
const luamin = require('luamin')
const luagen = require('luacodegen')
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

const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';

function generateVariable(length) {
    let result = '';
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

const func = (code) => {
    let ast = luaparse.parse(code, { scope: true, comments: false });

    let WhileLoopGeneration = (node) => {
        let oldNode = node;
        let oldClauses = oldNode.clauses;

        const conditionName = generateVariable(16);
        const conditionValue1 = Math.floor(Math.random() * 999999);
        const conditionValue2 = Math.floor(Math.random() * 999999);
        const incOrDecValue = Math.floor(Math.random() * 999999999);

        const junk = require("./components/flatten-junk")

        // console.log(decision1)

        let declareConditionLocal = {
            "type": "LocalStatement",
            "variables": [
                {
                    "type": "Identifier",
                    "name": conditionName,
                    "isLocal": true
                }
            ],
            "init": [
                {
                    "type": "NumericLiteral",
                    "value": conditionValue1,
                    "raw": `${conditionValue1}`
                }
            ]
        };

        let op;
        let op2;

        if (conditionValue1 > conditionValue2) {
            op = ">";
            op2 = "-";
        } else if (conditionValue1 < conditionValue2) {
            op = "<";
            op2 = "+";
        } else {
            op = "==";
            op2 = "-";
        }

        let whileDo = {
            "type": "WhileStatement",
            "condition": {
                "type": "BinaryExpression",
                "operator": op,
                "left": {
                    "type": "Identifier",
                    "name": conditionName,
                    "isLocal": true
                },
                "right": {
                    "type": "NumericLiteral",
                    "value": conditionValue2,
                    "raw": `${conditionValue2}`
                }
            },
            "body": [
                {
                    "type": "IfStatement",
                    "clauses": [
                        {
                            "type": "IfClause",
                            "condition": {
                                "type": "BinaryExpression",
                                "operator": op,
                                "left": {
                                    "type": "Identifier",
                                    "name": conditionName,
                                    "isLocal": true
                                },
                                "right": {
                                    "type": "NumericLiteral",
                                    "value": conditionValue2,
                                    "raw": `${conditionValue2}`
                                }
                            },
                            "body": [
                                {
                                    "type": "AssignmentStatement",
                                    "variables": [
                                        {
                                            "type": "Identifier",
                                            "name": conditionName,
                                            "isLocal": true
                                        }
                                    ],
                                    "init": [
                                        {
                                            "type": "BinaryExpression",
                                            "operator": op2,
                                            "left": {
                                                "type": "Identifier",
                                                "name": conditionName,
                                                "isLocal": true
                                            },
                                            "right": {
                                                "type": "NumericLiteral",
                                                "value": incOrDecValue,
                                                "raw": `${incOrDecValue}`
                                            }
                                        }
                                    ]
                                },
                                {
                                    "type": "DoStatement",
                                    "body": junk[Math.floor(Math.random() * junk.length)]
                                }
                            ]
                        }
                    ]
                },
                oldNode
            ]
        }

        let newNode = {
            "type": "DoStatement",
            "body": [
                // local statement
                // while statement
            ]
        };

        newNode.body.push(declareConditionLocal)
        newNode.body.push(whileDo)

        return newNode;
    };

    let extractElseIfsToIfs = (node) => {
        if (node.clauses.length > 1) {
            let newClauses = [];
            for (let i = 0; i < node.clauses.length; i++) {
                let clause = node.clauses[i];

                if (clause.type === 'ElseifClause') {
                    newClauses.push({
                        type: 'IfClause',
                        condition: clause.condition,
                        body: clause.body
                    });
                } else {
                    newClauses.push(clause);
                }
            }

            // Return a list of `IfStatement`s
            return {
                type: 'DoStatement',
                body: newClauses.map(clause => ({
                    type: 'IfStatement',
                    clauses: [clause]
                }))
            };
        }
        return node;
    }

    let funcs = [
        () => { visit(ast, "IfStatement", WhileLoopGeneration) }
    ]

    // console.log(funcs)

    let Iterations = Math.floor(Math.random() * 3) + 1

    // console.log(`Building Control Flow with Iterations: ${Iterations}...`)

    for (let i = 0; i < Iterations; i++) {
        for (let i2 of funcs) {
            i2()
        }
    }

    // fs.writeFileSync("./temp.json", JSON.stringify(ast, null, 4))

    let out = luagen(ast);

    // console.log("Finished building Control Flow Flattening with Iterations: " + Iterations)

    return out;
}

module.exports = func