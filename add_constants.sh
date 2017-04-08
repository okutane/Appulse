#!/bin/bash

echo "" >> config.h
echo "#define ROLLBAR_TOKEN \"$ROLLBAR_TOKEN\"" >> config.h
