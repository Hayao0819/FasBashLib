#!/usr/bin/env bash

# shellcheck source=/dev/null


Prog.Rotation "HogeRotate" "Loading... " &
sleep 2
Prog.Kill HogeRotate
