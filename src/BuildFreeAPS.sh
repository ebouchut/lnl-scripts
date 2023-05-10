#!/bin/bash # script BuildFreeAPS.sh

############################################################
# Required parameters for any build script that uses
#   inline build_functions
############################################################

BUILD_DIR=~/Downloads/BuildLoop
OVERRIDE_FILE=LoopConfigOverride.xcconfig
DEV_TEAM_SETTING_NAME="LOOP_DEVELOPMENT_TEAM"

#!inline build_functions.sh


############################################################
# The rest of this is specific to the particular script
############################################################

initial_greeting


############################################################
# Welcome & Branch Selection
############################################################

function choose_main_branch() {
    branch_select https://github.com/loopnlearn/LoopWorkspace.git freeaps FreeAPS_main
}

if [ -z "$CUSTOM_BRANCH" ]; then
    section_separator
    echo -e "\n ${RED}${BOLD}You are running the script to build FreeAPS"
    echo -e " This app is a fork based off of Loop 2.2.x."
    echo -e " Please consider Loop 3 instead.${NC}"
    echo -e " If you have not read this page - please review before continuing"
    echo -e "    https://www.loopandlearn.org/freeapsdoc"

    options=("Continue" "Cancel")
    actions=("choose_main_branch" "cancel_entry")
    menu_select "${options[@]}" "${actions[@]}"
else
    branch_select https://github.com/loopnlearn/LoopWorkspace.git $CUSTOM_BRANCH
fi

############################################################
# Standard Build train
############################################################

standard_build_train

############################################################
# Open Xcode
############################################################

section_separator
echo -e "The following item will open (when you are ready)"
echo -e "* Xcode ready to prep your current download for build"
before_final_return_message
echo -e ""
return_when_ready
cd $REPO_NAME
xed . 
exit_message
