#!/usr/bin/env bash
#
# This script is invoked by Travis during the script step on macOS.

# "Safe" bash
set -euf -o pipefail

# Directories we need
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_DIR="${SCRIPT_DIR}/../../.."
echo "SCRIPT_DIR=\"${SCRIPT_DIR}\""
echo "PROJECT_DIR=\"${PROJECT_DIR}\""

# Configure version
version="$(./version.sh)"
echo "version=\"${version}\""

# Setup the Qt path for cmake in a LocalConfig file
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

# Compilation
cmake "${PROJECT_DIR}"
make

# Create a macOS application bundle
echo "Creating bundle directory"
app_name="COLMAP-${version}.app"
mkdir -p "${BUILD_DIR}/${app_name}/Contents/MacOS"
echo "Copying binary to bundle directory"
cp "${BUILD_DIR}/colmap" "${BUILD_DIR}/${app_name}/Contents/MacOS/COLMAP"
echo "Writing Info.plist"
cat <<EOF > "${BUILD_DIR}/${app_name}/Contents/Info.plist"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleDevelopmentRegion</key>
    <string>English</string>
    <key>CFBundleExecutable</key>
    <string>COLMAP</string>
    <key>CFBundleGetInfoString</key>
    <string></string>
    <key>CFBundleIconFile</key>
    <string></string>
    <key>CFBundleIdentifier</key>
    <string></string>
    <key>CFBundleInfoDictionaryVersion</key>
    <string>6.0</string>
    <key>CFBundleLongVersionString</key>
    <string>${version}</string>
    <key>CFBundleName</key>
    <string>COLMAP</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>CFBundleShortVersionString</key>
    <string>${version}</string>
    <key>CFBundleSignature</key>
    <string>????</string>
    <key>CFBundleVersion</key>
    <string>${version}</string>
    <key>CSResourcesFileMapped</key>
    <true/>
    <key>LSRequiresCarbon</key>
    <true/>
    <key>NSHumanReadableCopyright</key>
    <string></string>
    <key>NSPrincipalClass</key>
    <string>NSApplication</string>
    <key>NSHighResolutionCapable</key>
    <true/>
    <key>NSAppSleepDisabled</key>
    <true/>
</dict>
</plist>
EOF
echo "Qt linking dynamic libraries"
/usr/local/opt/qt5/bin/macdeployqt "${BUILD_DIR}/COLMAP.app"

popd
