#!/bin/bash

for t in `ls ../public/assets/* | awk -Fyear '{print $1}' | sort -u | awk -F/ '{print $NF}' | sort -u`
do
    sed -i 's/\//\/'$t'/g' $t.rb
done
