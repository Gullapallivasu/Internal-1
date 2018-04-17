#!/bin/bash

#The tool is to find and replace all the phone numbers to a static value

find /var/www/ -type f -exec sed -i 's/[0-9]\{3\}[-. ][a-zA-Z0-9]\{3\}[-. ][a-zA-Z0-9]\{4\}\|[a-zA-Z0-9]\{10\}\|([0-9]\{3\})[-. ][a-zA-Z0-9]\{3\}\|[0-9]\{3\}[-. ][0-9]\{3\}[-. ][a-zA-Z0-9]\{3\}[-. ][a-zA-Z0-9]\{4\}\|([0-9]\{3\})[0-9]\{3\}[-. ][a-zA-Z0-9]\{3\}[-. ][a-zA-Z0-9]\{4\}/202-456-1414/g' {} \;
