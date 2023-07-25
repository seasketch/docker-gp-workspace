## 2023-07-25 release

:bug: Bugfix

* Fix miniconda version to `Miniconda3-py38_23.3.1-0`` to avoid dependency collision error when installing gdal in latest version released 07/12/23

## 2023-07-12 release

:rocket: New Feature / Improvement

* Add awscli package

## 2023-06-27 release

:boom: Breaking Changes

* Switch from `root` user to `vscode` user.  This resolve issue with some software not installing properly as root, specifically nvm.  Software such as nvm and miniconda is now staged in and installed to the vscode home directory. Opening a terminal while in your devcontainer will now open as `vscode` user.  We chose this user because it's already installed by Microsoft Ubuntu base image that we build on, has sudo rights, and a reasonable shell environment setup, so it made sense to just build on it.

:rocket: New Feature / Improvement

* Add Node 16 environment
* Update Makefile to work with `test` tag, since it's only used for doing test builds.  The Github CI action is responsible for publishing using a different multi-architecture mechanism (moby).

# 2023-06-13 release

:boom: Breaking Changes

* Add multi-arch support, now publishing both `amd64` and `arm64` builds.  This is a breaking change for Apple users with Apple Silicon (M1, M2, etc.).  You will need to delete your existing `geoprocessing-workspace` image(s), and then re-pull them.  It should automatically download the arm64 image this time.

:rocket: New Feature / Improvement

* Add platform-specific installer scripts to end of Dockerfile allowing to install platform-specific flavors of software dependencies.
