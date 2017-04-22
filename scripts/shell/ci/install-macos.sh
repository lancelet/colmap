#!/usr/bin/env bash
#
# This script is invoked by Travis during the install step on macOS.

# Setup some paths for cmake in a LocalConfig file
cat <<EOF > LocalConfig.cmake
set(Qt5_CMAKE_DIR "/usr/local/opt/qt5/lib/cmake")
set(Qt5Core_DIR ${Qt5_CMAKE_DIR}/Qt5Core)
set(Qt5OpenGL_DIR ${Qt5_CMAKE_DIR}/Qt5OpenGL)
EOF

# Create and enter the build directory
mkdir build
pushd build

# Do the build
cmake ..
make
