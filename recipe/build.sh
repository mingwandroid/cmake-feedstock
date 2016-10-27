#!/bin/bash

./bootstrap \
             --prefix="${PREFIX}" \
             --system-libs \
             --qt-gui \
             --no-system-libarchive \
             --no-system-jsoncpp \
             -- \
             -DCMAKE_BUILD_TYPE:STRING=Release \
             -DCMAKE_FIND_ROOT_PATH="${PREFIX}"

make
make install
