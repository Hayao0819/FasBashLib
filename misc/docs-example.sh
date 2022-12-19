#!/usr/bin/env bash

# @description My super function.
# Not thread-safe.
#
# @example
#    echo "test: $(say-hello World)"
#
# @arg $1 string A value to print
# @noargs
#
# @set VARIABLE
# @stdout Output string
#
# @exitcode 0 If successful.
# @exitcode 1 If an empty string passed.
#
# @see validate()
# @internal
