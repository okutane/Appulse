#!/bin/bash

echo "" >> Appulse-Bridging-Header.h
echo "#define ROLLBAR_TOKEN \"$ROLLBAR_TOKEN\"" >> Appulse-Bridging-Header.h
