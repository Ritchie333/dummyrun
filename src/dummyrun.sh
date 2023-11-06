#!/bin/sh
./sna2skool.py -h -H -c dummyrun.ctl dummyrun.z80 > dummyrun.skool
rm -rf ~/www/dummyrun/images/udgs/*
./skool2html.py -H -d ~/www dummyrun.skool
