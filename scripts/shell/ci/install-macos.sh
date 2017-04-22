#!/usr/bin/env bash
#
# This script is invoked by Travis during the install step on macOS.

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_DIR="${SCRIPT_DIR}/../../.."
echo "SCRIPT_DIR=\"${SCRIPT_DIR}\""
echo "PROJECT_DIR=\"${PROJECT_DIR}\""

# Setup some paths for cmake in a LocalConfig file
LOCAL_CONFIG_FILE="${PROJECT_DIR}/LocalConfig.cmake"
cat <<EOF > "${LOCAL_CONFIG_FILE}"
set(Qt5_CMAKE_DIR "/usr/local/opt/qt5/lib/cmake")
set(Qt5Core_DIR \${Qt5_CMAKE_DIR}/Qt5Core)
set(Qt5OpenGL_DIR \${Qt5_CMAKE_DIR}/Qt5OpenGL)
EOF
echo "Contents of ${LOCAL_CONFIG_FILE}:"
cat "${LOCAL_CONFIG_FILE}"
echo "End of ${LOCAL_CONFIG_FILE}"

# Do the build in a subdirectory
BUILD_DIR="${PROJECT_DIR}/build"
echo "Building in ${BUILD_DIR}"
mkdir -p "${BUILD_DIR}" && pushd "${BUILD_DIR}"
cmake "${PROJECT_DIR}"
make
popd
