#!/bin/bash

# Move to script's directory
cd "`dirname "$0"`"

sdlPath="$(cd "./SDL" && pwd -P)"

outputFolder="./binaries/osx"
rm -r -f $outputFolder
mkdir -p $outputFolder

logFolder="./logs/osx"
rm -r -f $logFolder
mkdir -p $logFolder

buildFolder="build"

sdlBuild="$sdlPath/$buildFolder"

# Generate SDL
echo "Generate SDL"

rm -r -f $sdlBuild

cmake -S $sdlPath -B $sdlBuild -DCMAKE_OSX_DEPLOYMENT_TARGET="10.15" -DCMAKE_OSX_ARCHITECTURES="arm64;x86_64" > "$logFolder/SDL.gen.log"

echo -e "\tDone"

# Build SDL
echo "Build SDL"

cmake --build $sdlBuild --target SDL3-shared > "$logFolder/SDL.bin.log"

cp -f "$sdlBuild/libSDL3.dylib" "$outputFolder/libSDL3.dylib"

echo -e "\tDone"
