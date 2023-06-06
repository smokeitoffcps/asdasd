@echo off
title NPM Init Setup

REM Set up npm init configuration
echo {^
  "dependencies": {^
    "discord.js": "^14.11.0",^
    "dotenv": "^16.1.4"^
  },^
  "name": "receivebot",^
  "version": "1.0.0",^
  "main": "src/index.js",^
  "devDependencies": {},^
  "scripts": {^
    "test": "src/index.js"^
  },^
  "author": "",^
  "license": "ISC",^
  "description": ""^
} > package.json

echo.
echo NPM Init Setup completed successfully.
pause
