#!/bin/sh
cd ${0%/*} || exit 1    # Run from this directory

# ----- OPTIONS ----- #
CASE = "meshSensitivity_fluid"


case $CASE in

    meshSensitivity_fluid)
        caseFolder=/meshSensitivity/fluidOnly
        mkdir -p .$caseFolder
        cp -a ..$caseFolder/. .$caseFolder
        chmod a+rwx .$caseFolder/*/Allrun
        for dep in .$caseFolder/*/Allrun; do "$dep"; done
        #sh .$caseFolder/*/Allrun
    ;;

    *)
        echo -n "unknown"
    ;;

esac

