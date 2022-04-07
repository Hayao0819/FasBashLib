#!/usr/bin/env bash

sed -E 's/(.)([A-Z])/\1_\2/g' | tr '[:upper:]' '[:lower:]'
