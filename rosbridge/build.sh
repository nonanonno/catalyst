#!/bin/bash

cd $(dirname $0)

BUILD_TYPE=${1:-debug}

scons platform=linux use_llvm=yes compiledb=yes target=template_$BUILD_TYPE
