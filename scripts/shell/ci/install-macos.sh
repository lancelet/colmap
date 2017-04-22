#!/usr/bin/env bash
#
# This script is invoked by Travis during the install step on macOS.

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_DIR="${SCRIPT_DIR}/../../.."

# Setup some paths for cmake in a LocalConfig file
cat <<EOF > "${PROJECT_DIR}/LocalConfig.cmake"
set(Qt5_CMAKE_DIR "/usr/local/opt/qt5/lib/cmake")
set(Qt5Core_DIR ${Qt5_CMAKE_DIR}/Qt5Core)
set(Qt5OpenGL_DIR ${Qt5_CMAKE_DIR}/Qt5OpenGL)
EOF

# Do the build in a subdirectory
mkdir "${PROJECT_DIR}/build"
pushd "${PROJECT_DIR}/build"
cmake "${PROJECT_DIR}"
make
popd
