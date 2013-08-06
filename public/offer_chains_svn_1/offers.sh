#!/usr/bin/env zsh
################################################################################
#                                                                              #
# Update offerchains from offers spreadsheet in the given environments.        #
# Usage: <PRESQL=update blah> ./offers.sh <spreadsheet.xls> <sqlplus1> <sqlplus2> ... <sqlplusX>             #
#                                                                              #
################################################################################

if [[ ! -f "$1" ]] ; then 
  echo "Invalid spreadsheet file: $1" 
  exit 1
fi

echo "Creating offers.auto.yaml from $1"
./bin/offersxls2yaml.py "$1" > offers.auto.yaml
echo "Creating offers.auto.sql from offers.auto.yaml"
./bin/offermaker.py offers.auto.yaml > offers.auto.sql
