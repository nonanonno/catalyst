#!/bin/bash
# Dump extension-api and build godot-cpp with it.
cd $(dirname $0)

pushd /tmp
godot --dump-extension-api --headless
popd

pushd godot-cpp
scons platform=linux custom_api_file=/tmp/extension_api.json use_llvm=yes
scons platform=linux custom_api_file=/tmp/extension_api.json target=template_release use_llvm=yes
popd
