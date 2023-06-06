@echo off
title Builder By Cobalt

REM Install discord.js and dotenv packages
npm install discord.js@^14.11.0 dotenv@^16.1.4 --save

REM Update package.json with the desired fields
echo {
echo   "dependencies": {
echo     "discord.js": "^14.11.0",
echo     "dotenv": "^16.1.4"
echo   },
echo   "name": "receivebot",
echo   "version": "1.0.0",
echo   "main": "src/index.js",
echo   "devDependencies": {},
echo   "scripts": {
echo     "test": "src/index.js"
echo   },
echo   "author": "",
echo   "license": "ISC",
echo   "description": ""
echo } > package.json

REM Run the application (node .)
node .

pause
