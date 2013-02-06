#!/bin/bash

curl -i -F file=$1 -F text=$2 http://localhost:4567/solve.json
