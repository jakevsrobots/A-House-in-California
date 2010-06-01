#!/bin/sh

mxmlc src/california/Main.as -source-path=src/ -source-path=asset_library/ -output output/AHouseInCalifornia.swf -static-link-runtime-shared-libraries -default-size 640 340 && flashplayer_10 output/AHouseInCalifornia.swf