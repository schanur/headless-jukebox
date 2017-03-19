#!/bin/bash

VENDOR_PATH="vendor/bundle"

sudo apt install bundler

mkdir -p ${VENDOR_PATH}

bundle install --path ${VENDOR_PATH}
bundle update
