#!/bin/sh

mxmlc src/california/Main.as -source-path=src/ -output output/AHouseInCalifornia.swf -static-link-runtime-shared-libraries -default-size 640 340 && flashplayer_10 output/AHouseInCalifornia.swf