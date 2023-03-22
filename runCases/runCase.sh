#!/bin/sh
cd ${0%/*} || exit 1    # Run from this directory

echo please choose an option:
echo   1. meshSensitivity_fluid
echo   2. CFD-DEM
echo   3. MP-PIC
echo   4. initSteady

read choiche

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

case $choiche in

    1) # meshSensitivity_fluid)
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

    2) # CFD-DEM)
        [ ! -d "./initSteady/" ] && initSteady
        caseFolder=/CFD-DEM
        mkdir -p .$caseFolder
        cp -a -n ..$caseFolder/. .$caseFolder
        chmod a+rwx .$caseFolder/*/Allrun
        for dep in .$caseFolder/*
        do
            cp -a -n ../meshSensitivity/fluidOnly/finer_1/. $dep/
            cp -a -n .$caseFolder/BASE/. $dep/
        done
            rm -r .$caseFolder/BASE
        for dep in .$caseFolder/*/Allrun; do "$dep"; done
    ;;

    3) # MP-PIC)
        [ ! -d "./initSteady/" ] && initSteady
        caseFolder=/MP-PIC
        mkdir -p .$caseFolder
        cp -a -n ..$caseFolder/. .$caseFolder
        chmod a+rwx .$caseFolder/*/Allrun
        for dep in .$caseFolder/*
        do
            cp -a -n ../meshSensitivity/fluidOnly/finer_1/. $dep/
            cp -a -n .$caseFolder/BASE/. $dep/
        done
            rm -r .$caseFolder/BASE
        for dep in .$caseFolder/*/Allrun; do "$dep"; done
    ;;

    4) # initSteady)
        initSteady
    ;;

    *)
        echo -n "unknown"
    ;;

esac

