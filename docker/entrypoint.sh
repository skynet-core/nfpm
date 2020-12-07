#!/bin/sh -l

if [ "x$INPUT_CONFIG" != "x" ] && [ "x$INPUT_PACKAGER" != "x" ]; then
    if [ "x$INPUT_TARGET" != "x" ]; then
        name=$(sudo sh -c "nfpm pkg -f $INPUT_CONFIG -p $INPUT_PACKAGER -t $INPUT_TARGET" | grep "created package:" | sed 's|created package: ||g')
    else
        name=$(sudo sh -c "nfpm pkg -f $INPUT_CONFIG -p $INPUT_PACKAGER" | grep "created package:" | sed 's|created package: ||g')
    fi
    if [ "x$name" == "x" ]; then
        exit 1
    fi
    echo "::set-output name=package::$name"
else
    sh -c "$@"
fi
