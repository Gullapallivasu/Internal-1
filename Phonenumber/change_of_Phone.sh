#!/bin/bash

#The tool is to find and replace all the phone numbers to a static value

find /var/www/ -type f -name "*html" -exec sed -ri 's/.[0-9]+[^0-9]*[a-zA-Z0-9]+[^0-9]*[a-zA-Z0-9]+[-. ]*[a-zA-Z0-9]+./ 202-456-1414 /g' {} +
