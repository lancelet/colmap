# Scripts for Travis CI

This directory contains scripts that will be invoked by [Travis CI][travis-ci]
when building and deploying packages. The main Travis configuration is
contained in `.travis.yml`, in the root directory of the repository.

## Creating a new Build Configuration

A build configuration is a complete set of all configuration for a build,
including things such as:
  - Platform (eg. macOS / Linux)
  - Compilation settings (eg. optimizations, GPU settings)
  - etc.

Build configurations are set up using a Travis [Build Matrix][travis-matrix].
In brief, to add a new configuration:
  1. Add the configuration and its Travis-related settings to the `matrix` in 
     the `.travis.yml` file in the root of the project. Multiple examples of
     project configurations exist in both public GitHub repositories and in the 
     Travis documentation.
  2. For build steps that are non-trivial, add build scripts to this CI scripts
     directory and call them from the appropriate steps of the `.travis.yml`
     file.

## Release Versioning

When tracking down end-user problems, it is very useful to know exactly which
binary artifact the user was running. For this purpose, the release version
should include enough information to establish exactly which binary was being
run. For now, the release information includes:
  - Nominal version (eg. `2.1`)
  - Build timestamp
  - Shortened git commit hash

This can be expanded as required.

## Initial Travis setup

Before Travis will build anything, it is necessary to configure Travis itself.
This must be done on the [travis-ci.org](https://travis-ci.org) website, not
via GitHub:
  1. Login to Travis.
  2. Turn on builds for the project.

Once this has been done, the next commit against any branch of the fork will
trigger a build in Travis. Each individual GitHub fork, including the original,
must have its own build configured. (AFAICT, it is not possible to share this
initial Travis setup among forks, although the configuration is shared since it
lives in the repository.)

## Deploying GitHub Releases

Travis can upload artifacts to GitHub. Documentation for
this [release capability][travis-release] is available from Travis. Once this
capability has been setup, Travis will create a new release every time a new tag
is pushed to GitHub. Artifacts are published to GitHub by Travis during a
deployment stage. These artifacts can then be served directly from GitHub, or
copied to an appropriate server for public consumption.

[travis-ci]: https://travis-ci.org
[travis-matrix]: https://docs.travis-ci.com/user/customizing-the-build/#Build-Matrix
[travis-release]: https://docs.travis-ci.com/user/deployment/releases/
