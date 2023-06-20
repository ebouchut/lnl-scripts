#!/bin/bash # script CustomizationSelect.sh

BUILD_DIR=~/Downloads/BuildLoop

#!inline patch_functions.sh

############################################################
# The rest of this is specific to the particular script
############################################################

message_incompatible_count=0

# this is always used - it is the introductory message - it can be blank
# it comes before any customizations are presented
function message_generic() {
    echo "  These Customizations are documented on the Loop and Learn web site"
    echo "        https://www.loopandlearn.org/custom-code/#custom-list"
    echo
}

# this is always used - it is the incompatible patches message - it can be blank
function message_incompatible() {
    :
}

# in order for optional messages to appear after the add_customization line
# must use printf
# optional message to go with add_customization line
function message_to_add_blank_line() {
    printf "\n"
}

function message_for_cto() {
    printf "        https://www.loopandlearn.org/custom-type-one-loop-patches/\n"
    printf "        Update automatic when Glucose Based Application Factor also selected.\n\n"
}

# optional message to go with add_customization line
function message_for_pr1988() {
    printf "      This feature in development gradually increases AB factor with glucose.\n"
    printf "      Replaces CustomTypeOne LoopPatches ${INFO_FONT}switcher patch${NC}.\n"
    printf "        https://github.com/LoopKit/Loop/pull/1988\n\n"
}

# optional message to go with add_customization line
function message_for_pr2002() {
    printf "      This feature in development enables save and restore of named profiles.\n"
    printf "        https://github.com/LoopKit/Loop/pull/2002\n\n"
}

function message_for_pr2008() {
    printf "      This feature in development modifies retrospective correction.\n"
    printf "      Helps when glucose differs from setting-based predictions.\n"
    printf "        https://github.com/LoopKit/Loop/pull/2008\n\n"
}

# list patches in this order with args:
#   User facing information for option
#   Folder name in the patch repo
#   (Optional) message function shown prior to option

add_customization "CAGE: Upload Pod Start to Nightscout" "omnipod_cage"
add_customization "SAGE: Upload Dexcom Sensor Start to Nightscout" "dexcom_sage"
add_customization "Change Default to Upload Dexcom Readings" "dexcom_upload_readings"
add_customization "Increase Future Carbs Limit to 4 hours" "future_carbs_4h"
add_customization "Modify Carb Warning & Limit: Low Carb to 49 & 99" "low_carb_limit"

add_customization "Modify Carb Warning & Limit: High Carb to 201 & 300" "high_carb_limit"
add_customization "Disable Authentication Requirement" "no_auth"
add_customization "Override Insulin Needs Picker (50% to 200%, steps of 5%)" "override_sens"
add_customization "Libre Users: Limit Loop to 5 minute update" "limit_loop_cycle_time"
add_customization "Modify Logo to include LnL icon" "lnl_icon" "message_to_add_blank_line"

add_customization "CustomTypeOne LoopPatches" "customtypeone_looppatches" "message_for_cto"

add_customization "Profile Save & Load" "2002" "message_for_pr2002"
add_customization "Glucose Based Application Factor" "1988" "message_for_pr1988"
add_customization "Integral Retrospective Correction" "2008" "message_for_pr2008"

param_zero_is_customization
param_zero_result=$?

if [ $param_zero_result -eq 0 ]; then
    patch_command_line $0 "$@"
elif [ $# -gt 0 ]; then
    patch_command_line "$@"
else
    patch_menu
fi