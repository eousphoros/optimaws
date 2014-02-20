#!/bin/bash

for t in `ls ../public/assets/* | awk -Fyear '{print $1}' | sort -u | awk -F/ '{print $NF}'`
do
  for i in `ls ../public/assets/$t* | awk -F/ '{print $NF}'`
  do
    echo "%object{ :type => \"image/svg+xml\", :data => \"/assets/"$i"\", :width => \"400\", :height => \"400\""}
  done > $t.haml
done
