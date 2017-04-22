#!/usr/bin/env bash
#
# This script returns a version string. The version appears as follows:
#
#    2.2-snapshot-20170422230244-43fd2f5
#    ^^^^^^^^^^^^ ^^^^^^^^^^^^^^ ^^^^^^^
#          |             |          |
#          |             |          '----- Short git hash
#          |             '---------------- Timestamp of build
#          '------------------------------ Nominal release
#
# Usage example:
# version="$(./version.sh)"

# "Safe" bash
set -euf -o pipefail

# establish directory locations
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
project_dir="${script_dir}/../../.."
version_file="${project_dir}/VERSION.txt"

# components of the version number
release="$(cat ${version_file})"
hash="$(git rev-parse --short HEAD)"
timestamp="$(date '+%Y%m%d%H%M%S')"

# echo out the version number
version="${release}-${timestamp}-${hash}"
echo "${version}"
