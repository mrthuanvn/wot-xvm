#!/bin/bash

#XVM-Stat builder for Linux
#Part of XVM build system
#Do not change anything in this file if you are not sure

rm -rf ../../../src/xvm-stat/bin/*
rm -rf ../../../src/xvm-stat/obj/*

pushd ../../../src/xvm-stat/
/opt/mono-3/bin/xbuild xvm-stat.csproj /p:Configuration="Release" /p:TargetFrameworkProfile="" /p:SignAssembly="False" /p:win32icon="WoT.ico"
popd
