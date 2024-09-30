module.exports = [
    [ // fake get_bits_32
        {
            "type": "FunctionDeclaration",
            "identifier": {
                "type": "Identifier",
                "name": "REP_VAR_NAME"
            },
            "isLocal": true,
            "parameters": [
                {
                    "type": "Identifier",
                    "name": "REP_VAR_NAME_1"
                },
                {
                    "type": "Identifier",
                    "name": "REP_VAR_NAME_2"
                },
                {
                    "type": "Identifier",
                    "name": "REP_VAR_NAME_3"
                },
                {
                    "type": "Identifier",
                    "name": "REP_VAR_NAME_4"
                }
            ],
            "body": [
                {
                    "type": "ReturnStatement",
                    "arguments": [
                        {
                            "type": "BinaryExpression",
                            "operator": "+",
                            "left": {
                                "type": "BinaryExpression",
                                "operator": "+",
                                "left": {
                                    "type": "BinaryExpression",
                                    "operator": "+",
                                    "left": {
                                        "type": "BinaryExpression",
                                        "operator": "*",
                                        "left": {
                                            "type": "Identifier",
                                            "name": "REP_VAR_NAME_4"
                                        },
                                        "right": {
                                            "type": "NumericLiteral",
                                            "value": 16777216,
                                            "raw": "16777216"
                                        }
                                    },
                                    "right": {
                                        "type": "BinaryExpression",
                                        "operator": "*",
                                        "left": {
                                            "type": "Identifier",
                                            "name": "REP_VAR_NAME_3"
                                        },
                                        "right": {
                                            "type": "NumericLiteral",
                                            "value": 65536,
                                            "raw": "65536"
                                        }
                                    }
                                },
                                "right": {
                                    "type": "BinaryExpression",
                                    "operator": "*",
                                    "left": {
                                        "type": "Identifier",
                                        "name": "REP_VAR_NAME_2"
                                    },
                                    "right": {
                                        "type": "NumericLiteral",
                                        "value": 256,
                                        "raw": "256"
                                    }
                                }
                            },
                            "right": {
                                "type": "Identifier",
                                "name": "REP_VAR_NAME_1"
                            }
                        }
                    ]
                }
            ]
        },
        {
            "type": "CallStatement",
            "expression": {
                "type": "CallExpression",
                "base": {
                    "type": "Identifier",
                    "name": "REP_VAR_NAME"
                },
                "arguments": [
                    {
                        "type": "NumericLiteral",
                        "value": [
                            {
                                "type": "FunctionDeclaration",
                                "identifier": {
                                    "type": "Identifier",
                                    "name": "REP_VAR_NAME"
                                },
                                "isLocal": true,
                                "parameters": [
                                    {
                                        "type": "Identifier",
                                        "name": "REP_VAR_NAME_1"
                                    },
                                    {
                                        "type": "Identifier",
                                        "name": "REP_VAR_NAME_2"
                                    },
                                    {
                                        "type": "Identifier",
                                        "name": "REP_VAR_NAME_3"
                                    },
                                    {
                                        "type": "Identifier",
                                        "name": "REP_VAR_NAME_4"
                                    }
                                ],
                                "body": [
                                    {
                                        "type": "ReturnStatement",
                                        "arguments": [
                                            {
                                                "type": "BinaryExpression",
                                                "operator": "+",
                                                "left": {
                                                    "type": "BinaryExpression",
                                                    "operator": "+",
                                                    "left": {
                                                        "type": "BinaryExpression",
                                                        "operator": "+",
                                                        "left": {
                                                            "type": "BinaryExpression",
                                                            "operator": "*",
                                                            "left": {
                                                                "type": "Identifier",
                                                                "name": "REP_VAR_NAME_4"
                                                            },
                                                            "right": {
                                                                "type": "NumericLiteral",
                                                                "value": 16777216,
                                                                "raw": "16777216"
                                                            }
                                                        },
                                                        "right": {
                                                            "type": "BinaryExpression",
                                                            "operator": "*",
                                                            "left": {
                                                                "type": "Identifier",
                                                                "name": "REP_VAR_NAME_3"
                                                            },
                                                            "right": {
                                                                "type": "NumericLiteral",
                                                                "value": 65536,
                                                                "raw": "65536"
                                                            }
                                                        }
                                                    },
                                                    "right": {
                                                        "type": "BinaryExpression",
                                                        "operator": "*",
                                                        "left": {
                                                            "type": "Identifier",
                                                            "name": "REP_VAR_NAME_2"
                                                        },
                                                        "right": {
                                                            "type": "NumericLiteral",
                                                            "value": 256,
                                                            "raw": "256"
                                                        }
                                                    }
                                                },
                                                "right": {
                                                    "type": "Identifier",
                                                    "name": "REP_VAR_NAME_1"
                                                }
                                            }
                                        ]
                                    }
                                ]
                            },
                            {
                                "type": "CallStatement",
                                "expression": {
                                    "type": "CallExpression",
                                    "base": {
                                        "type": "Identifier",
                                        "name": "REP_VAR_NAME"
                                    },
                                    "arguments": [
                                        {
                                            "type": "NumericLiteral",
                                            "raw": `${Math.floor(Math.random() * 99999)}`
                                        },
                                        {
                                            "type": "NumericLiteral",
                                            "raw": `${Math.floor(Math.random() * 99999)}`
                                        },
                                        {
                                            "type": "NumericLiteral",
                                            "raw": `${Math.floor(Math.random() * 99999)}`
                                        },
                                        {
                                            "type": "NumericLiteral",
                                            "raw": `${Math.floor(Math.random() * 99999)}`
                                        }
                                    ]
                                }
                            }
                        ],
                        "raw": "12"
                    },
                    {
                        "type": "NumericLiteral",
                        "raw": `${Math.floor(Math.random() * 99999)}`
                    },
                    {
                        "type": "NumericLiteral",
                        "raw": `${Math.floor(Math.random() * 99999)}`
                    },
                    {
                        "type": "NumericLiteral",
                        "raw": `${Math.floor(Math.random() * 99999)}`
                    }
                ]
            }
        }
    ],
]