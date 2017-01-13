#!/usr/bin/env bash

for ending in `echo aa ab ac ad ae`;
do
    wget "http://cs.mcgill.ca/~npow1/data/ubuntu_dataset.tgz.${ending}"
done

cat ubuntu_dataset.tgz.* > ubuntu_full_dataset.tgz
tar -xvzf ubuntu_full_dataset.tgz data
