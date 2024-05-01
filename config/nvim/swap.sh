#!/usr/bin/env bash
mv ~/init.lua ./init.lua.temp
mv ./init.lua ~/init.lua
mv ./init.lua.temp ./init.lua
head -n 1 ./init.lua
