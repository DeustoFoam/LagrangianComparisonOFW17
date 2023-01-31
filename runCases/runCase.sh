#!/bin/sh
cd ${0%/*} || exit 1    # Run from this directory

# ------ OPTIONS ------ #
CASE="initSteady"

# ----- FUNCTIONS ----- #
initSteady()
{
    echo "Initializing steady state flow"
    caseFolder=/initSteady
    mkdir -p .$caseFolder
    cp -a -n ..$caseFolder/. .$caseFolder
    for dep in .$caseFolder/*/
    do
        cp -a -n .$caseFolder/BASE/. $dep/
    done
        rm -r .$caseFolder/BASE
    chmod a+rwx .$caseFolder/*/Allrun
    for dep in .$caseFolder/*/Allrun; do "$dep"; done
}

case $CASE in

    meshSensitivity_fluid)
        caseFolder=/meshSensitivity/fluidOnly
        mkdir -p .$caseFolder
        cp -a -n ..$caseFolder/. .$caseFolder
        for dep in .$caseFolder/*/
        do
            cp -a -n .$caseFolder/BASE/. $dep/
        done
        chmod a+rwx .$caseFolder/*/Allrun
        for dep in .$caseFolder/*/Allrun; do "$dep"; done
    ;;

    CFD-DEM)
        caseFolder=/CFD-DEM
        mkdir -p .$caseFolder
        cp -a -n ..$caseFolder/. .$caseFolder
        chmod a+rwx .$caseFolder/*/Runhalf
        for dep in .$caseFolder/*/Runhalf; do "$dep"; done
    ;;

    MP-PIC)
        caseFolder=/MP-PIC
        mkdir -p .$caseFolder
        cp -a -n ..$caseFolder/. .$caseFolder
        chmod a+rwx .$caseFolder/*/Runhalf
        for dep in .$caseFolder/*/Runhalf; do "$dep"; done
    ;;

    initSteady)
        initSteady
    ;;

    *)
        echo -n "unknown"
    ;;

esac

