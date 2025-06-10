#! /usr/bin/bash

git as -a
git co main
git push origin main
git co main-fhd
git push -f origin main-fhd
git co do-not-push
