#!/bin/sh

rm output/AHouseInCalifornia.swf
mxmlc src/california/Main.as -source-path=src/ -output output/AHouseInCalifornia.swf
flashplayer_10 output/AHouseInCalifornia.swf