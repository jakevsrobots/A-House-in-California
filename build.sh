#!/bin/sh

rm output/AfterAndBefore.swf
python src/compile_levels.py
mxmlc src/net/dai5ychain/afterandbefore/AfterAndBefore.as -source-path=src/ -output output/AfterAndBefore.swf
flashplayer_10 output/AfterAndBefore.swf