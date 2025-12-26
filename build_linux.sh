#!/bin/bash

# Move to script's directory
cd "`dirname "$0"`"

arch=$1

sdlPath="$(cd "./SDL" && pwd -P)"

outputFolder="./binaries/linux-$arch"
rm -r -f $outputFolder
mkdir -p $outputFolder

logFolder="./logs/linux-$arch"
rm -r -f $logFolder
mkdir -p $logFolder

buildFolder="build"

sdlBuild="$sdlPath/$buildFolder"

# Generate SDL
echo "Generate SDL"

rm -r -f $sdlBuild

cmake -S $sdlPath -B $sdlBuild > "$logFolder/SDL.gen.log"

echo -e "\tDone"

# Build SDL
echo "Build SDL"

cmake --build $sdlBuild --target SDL3-shared > "$logFolder/SDL.bin.log"

cp -f "$sdlBuild/libSDL3.so" "$outputFolder/libSDL3.so"

echo -e "\tDone"
