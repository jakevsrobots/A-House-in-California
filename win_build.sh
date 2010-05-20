#!/bin/sh

mxmlc.exe src/california/Main.as -source-path=src/ -output output/AHouseInCalifornia.swf -static-link-runtime-shared-libraries && /c/flex4/runtimes/player/10/win/FlashPlayer.exe output/AHouseInCalifornia.swf