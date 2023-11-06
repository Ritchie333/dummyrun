#!/bin/zsh

#sna2skool.py -H -c src/dummyrun.ctl sources/dummyrun.z80 > sources/dummyrun.skool
rm -rf dummyrun
skool2html.py -H -T dark -W src/:dummyrun.HerbertHtmlWriter src/dummyrun.skool


