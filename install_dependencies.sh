#!/bin/bash

VENDOR_PATH="vendor/bundle"

mkdir -p ${VENDOR_PATH}

bundle install --path ${VENDOR_PATH}
bundle update
