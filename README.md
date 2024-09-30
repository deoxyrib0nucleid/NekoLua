# NEKOLUA
### The most braindead and generic VM based lua obfuscator!

Hey! I have been in this community for around 4 months now (Currently September 29, 2024 while writing this) and I want to retire for a little bit and relax, I will eventually come back in the lua obfuscation community but for now, this will be currently my last obfuscation project -from oxidanedev

## How to use?
1. Download the github repository and place it to a folder in your pc
2. Open cmd or powershell
3. Change directory to the folder you placed the obfuscator files (cd C:\something here\something that\obfuscator)
4. Paste your script in "Script.lua"
5. Run on the command line: "lua index.lua" (replace lua with whatever lua shit u have example: luajit, lua5.2)
6. Wait to finish
7. To get output, extract from Output.lua
8. To execute, run the output with "lua Output.lua" (again replace lua with whatever lua shit u have)
9. Enjoy.

## Information
- Version: Alpha 1.0
- Supported Lua Versions/Forks: Luau, LuaJIT, Lua 5.1, Lua 5.2, Lua 5.3 (maybe)

## Credits
* Rerumu: for fione and vm structure (opcodes as well)
* Kein-Hong Man: for lua compiler in lua (yueliang)
* IB2 Owners: for several tests ran and also benchmark code
* xiedacon: fs library
* Stravant: old lua minifier library
* fstirlitz: lua parsing library in javascript
* Mathias Bynens: lua minifier based of fstirlitz's lua parser.
* Herrtt: alternative lua parsing library that comes with a beautifier, minifier, and uglifier
* wavetilt: lua code generation from fstirlitz's lua parser AST output.

lmk if i forgot to credit some people

## WARNING
I will DMCA immediately those people who fork this without publishing the forked source as a fork of my project when I am informed.
DMCA Request (discord username): deoxyrib0nucleid

## WARNING (again)
DO NOT CHANGE THE CODE IN THE NODE_MODULES FOLDER OR REINSTALL THEM, THERE IS A POSSIBLITY THAT IT MIGHT BREAK THE EXPECTED OBFUSCATED OUTPUT (they are heavily modified to meet the control flow generation needs)

## LICENSE
### Registered under AGPL-3.0
