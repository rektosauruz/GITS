#!/bin/bash


echo "please give the string to be converted to md5 format"
read u_input

echo "sha256 of $u_input : `echo -n "$u_input" | sha256sum`"
