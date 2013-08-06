#!/bin/bash

python offermaker.py <(python offersxls2yaml.py "$1")
