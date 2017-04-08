#!/bin/bash
set -o errexit -o nounset -o pipefail


VENDOR_PATH="vendor/bundle"
PACKAGE_LIST="bundler ruby mpv alsa-utils"
PACKAGE_LIST_RASPBERRY_PI="omxplayer"

function package_is_installed {
    local PACKAGE_NAME=${1}
    local IS_INSTALLED=1

    dpkg -l ${PACKAGE_NAME} &> /dev/null || IS_INSTALLED=0

    echo ${IS_INSTALLED}
}

# Detect Raspberry Pis.
# TODO: Currently detects all ARM boards as raspberry.
function is_raspberry_pi {
    local IS_RASPBERRY_PI=0

    if [ "$(uname -r)" = "arm" ]; then
        IS_RASPBERRY_PI=1
    fi

    echo ${IS_RASPBERRY_PI}
}

if [ $(is_raspberry_pi) -eq 1 ]; then
    PACKAGE_LIST="${PACKAGE_LIST} ${PACKAGE_LIST_RASPBERRY_PI}"
fi

ALL_PACKAGES_INSTALLED=1
for PACKAGE in ${PACKAGE_LIST}; do
    echo -n "${PACKAGE} instlled: "
    if [ $(package_is_installed ${PACKAGE}) -eq 1 ]; then
        echo "yes"
    else
        echo "no"
        ALL_PACKAGES_INSTALLED=0
    fi
done

if [ ${ALL_PACKAGES_INSTALLED} = 0 ]; then
    sudo apt install "${PACKAGE_LIST}"
fi


mkdir -p ${VENDOR_PATH}
bundle install --path ${VENDOR_PATH}
bundle update
