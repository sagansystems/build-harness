#!/bin/bash
export BUILD_HARNESS_PROJECT=${2:-build-harness}
export BUILD_HARNESS_BRANCH=${3:-circle-2.0}
export GITHUB_REPO="git@github.com:sagansystems/${BUILD_HARNESS_PROJECT}.git"

cd ~
if [ "$BUILD_HARNESS_PROJECT" ] && [ -d "$BUILD_HARNESS_PROJECT" ]; then
	echo "Removing existing $BUILD_HARNESS_PROJECT"
  rm -rf "$BUILD_HARNESS_PROJECT"
fi

git clone -b $BUILD_HARNESS_BRANCH $GITHUB_REPO
make -C $BUILD_HARNESS_PROJECT deps circle:deps
