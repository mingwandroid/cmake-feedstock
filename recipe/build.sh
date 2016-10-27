#!/bin/bash


# FIXME: This is a hack to make sure the environment is activated.
# The reason this is required is due to the conda-build issue
# mentioned below.
#
# https://github.com/conda/conda-build/issues/910
#
source activate "${CONDA_DEFAULT_ENV}"

if [[ `uname` == 'Darwin' ]];
then
    export LIBRARY_SEARCH_VAR=DYLD_FALLBACK_LIBRARY_PATH
else
    export LIBRARY_SEARCH_VAR=LD_LIBRARY_PATH
fi


./bootstrap \
             --prefix="${PREFIX}" \
             --system-libs \
             --qt-gui \
             --no-system-libarchive \
             --no-system-jsoncpp \
             -- \
             -DCMAKE_BUILD_TYPE:STRING=Release \
             -DCMAKE_FIND_ROOT_PATH="${PREFIX}" \
             -DCMAKE_USE_SYSTEM_LIBUV=OFF

make VERBOSE=1
eval ${LIBRARY_SEARCH_VAR}="${PREFIX}/lib" make install
