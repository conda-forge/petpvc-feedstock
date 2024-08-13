#!/usr/bin/env bash

set -ex

# config
cmake ${CMAKE_ARGS} \
	-D CMAKE_BUILD_TYPE:STRING=Release \
	-D CMAKE_INSTALL_PREFIX:STRING=${PREFIX} \
	-G Ninja \
	-B build \
	-S ${SRC_DIR}

# build
cmake --build build --parallel ${CPU_COUNT}

# install
cmake --install build

# post-install
rm -rf "${PREFIX}/parc"

# test
if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR}" != "" ]]; then
ctest --test-dir build --extra-verbose --output-on-failure
fi
