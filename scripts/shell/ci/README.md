# Scripts for Travis CI

This directory contains scripts that will be invoked by [Travis CI][travis-ci]
when building and deploying packages. The main Travis configurations is
contained in `.travis.yml`, in the root directory of the repository.

## Uploading to GitHub Releases

Travis can upload built artifacts to git tags in the GitHub repository. To
configure this capability please see
the [Travis release documentation][travis-release].

[travis-ci]: https://travis-ci.org
[travis-release]: https://docs.travis-ci.com/user/deployment/releases/
