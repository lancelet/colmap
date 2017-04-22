#!/usr/bin/env bash
#
# This script is invoked by Travis during the before_install step on macOS.

# Add some extra homebrew dependencies in a new tap, and update
brew tap homebrew/science
brew update

# Upgrade pre-installed packages (the two-stage thing is to avoid errors if a
# package is already at the latest version)
brew outdated cmake || brew upgrade cmake
brew outdated boost || brew upgrade boost

# Install new packages
brew install      \
     eigen        \
     freeimage    \
     glog         \
     gflags       \
     suite-sparse \
     ceres-solver \
     qt5          \
     glew
