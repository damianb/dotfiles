#!/bin/bash

newtermgeom="echo $(slop -c 0.918,0.525,0 -b 3 -f "%wx%h+%x+%y")"
terminator --geometry=$(eval $newtermgeom)
