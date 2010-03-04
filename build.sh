#!/bin/sh

rm output/GlowingInsects.swf
python src/compile_levels.py
mxmlc src/net/dai5ychain/glowinginsects/GlowingInsects.as -source-path=src/ -output output/GlowingInsects.swf
flashplayer_10 output/GlowingInsects.swf