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

echo "PLATO: Creating offers.auto.yaml from $1"
python $2/offersxls2yaml.py "$1" > $2/offers.auto.yaml

echo "PLATO: Creating offers.auto.sql from offers.auto.yaml"
python $2/offermaker_plato_phase_1.py $2/offers.auto.yaml > $2/offers.auto.sql
