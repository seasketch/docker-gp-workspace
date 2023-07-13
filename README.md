# Docker image for seasketch geoprocessing workspace

The `docker-gp-workspace` repository builds and publishes a [Docker image](https://hub.docker.com/r/seasketch/geoprocessing-workspace) providing a stable [devcontainer workspace](https://github.com/seasketch/geoprocessing-devcontainer) for SeaSketch [geoprocessing](https://github.com/seasketch/geoprocessing) projects.

Features:

- uses Ubuntu LTS image
- includes common utilities for compiling software from source
- includes conda (via miniconda) with a `base` environment that has Python and GDAL.  Users can adapt or create new environments
- can be used as a shell environment workspace for users and for heavy geo lifting by geoprocessing CLI commands
- is built and distributed with the computing resources provided by github and dockerhub.

## Usage

You should not need to work with this repository directly, unless you need to extend the `geoprocessing-workspace` image to meet your own needs.

To do this, clone the repository locally, make any changes you want to the Dockerfile or related architecture-specific installer scripts, then use the `Makefile` to build and test it.  You will need to have the `make` software package already installed.

Use the makefile for changing the build build by building images locally and testing them by shelling in to check it out, and by running the test suite.  Committing changes to `main` branch in Github will then rebuild and publish the container image via the `publish` Github action.

- `make` builds an `amd64` Docker image and tags it as 'test', to differentiate it from any of the 'latest' images you might have installed.
- `make test` Runs test suite on the 'test' image
- `make shell` Starts a container using 'test' image (building it first if necessary), then opens a bash shell.  This is useful for testing that your Dockerfile changes are working as expected.

## Packages and version numbers

Operating system:
* Ubuntu Jammy 22.04 LTS with Python 3.9

Libraries:

```
PROJ_VERSION 8.0.1
GDAL_VERSION 3.3.1
SQLITE_VERSION 3.4
```

## GDAL

GDAL 3.3.1 is used because it supports flatgeobuf files, and works with flatgeobuf JS library v3.17.4 that geoprocessing lib is locked on for now

## Alternative Uses

You can run standalone commands using the Docker image, for example bringing input data into a container, transforming it using GDAL, and then bringing the result back out of the container

The following command binds your current working directory in your host operating system to the `/data` path in the container.  You can read from `/data` and then write to it to persist data in your host operating system.:

```bash
docker run --rm -it \
    --volume $(shell pwd)/:/data \
    seasketch/geoprocessing-workspace:latest \
    gdalinfo /data/your.tif
```

You can set this up as an alias to run commands in a container in a way that is very similar to how you would run it directly in your operating system.

```bash
function with-gp-base {
    docker run --rm -it --volume $(pwd)/:/data seasketch/geoprocessing-workspace:latest "$@"
}

with-gp-base gdalinfo /data/your.tif
```

## License

`docker-gp-workspace` source code and associated images on dockerhub available as **public domain**

Inspired by [perrygeo/docker-gdal-base](https://github.com/perrygeo/docker-gdal-base)
