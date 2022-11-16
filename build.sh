#!/bin/sh

BASEDIR=$(realpath $(dirname $0)/.)
docker build -t scor/ruby-android-ndk:latest $BASEDIR/