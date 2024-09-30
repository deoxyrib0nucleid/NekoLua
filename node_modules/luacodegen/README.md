# luacodegen

`luacodegen` generates lua code from an ast. It is intended to be used with the tree produced by `luaparse` but this is not a hard requirement. The code generated is intended to have exactly the same ast as the initial input except with better formatting.

## Example
```js
const luaparse = require("luaparse");
const luacodegen = require("luacodegen");

const tree = luaparse.parse("local function a(b) if (b) then return 1 else return 2 end end");
const code = luacodegen(tree);
/*
local function a (b)
	if (b) then
		return 1;
	else
		return 2;
	end
end
*/
```
