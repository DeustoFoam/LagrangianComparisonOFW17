#!/bin/sh
cd ${0%/*} || exit 1    # Run from this directory

# ----- OPTIONS ----- #
CASE="meshSensitivity_fluid"


case $CASE in

    meshSensitivity_fluid)
        caseFolder=/meshSensitivity/fluidOnly
        mkdir -p .$caseFolder
        cp -a -n ..$caseFolder/. .$caseFolder
        for dep in .$caseFolder/*/
        do
            cp -a -n .$caseFolder/original/. $dep/
        done
        chmod a+rwx .$caseFolder/*/Allrun
        for dep in .$caseFolder/*/Allrun; do "$dep"; done
    ;;

    *)
        echo -n "unknown"
    ;;

esac

