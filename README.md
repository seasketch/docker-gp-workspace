# Docker image for seasketch geoprocessing workspace

`docker-gp-workspace` builds a reliable base image for creating a GIS workspace for SeaSketch [geoprocessing](https://github.com/seasketch/geoprocessing) projects

Features:
- uses recent Ubuntu LTS image
- includes common utilities for compiling software from source
- includes conda with a `base` environment that has Python and GDAL.  Users can adapt or create new environments
- can be used as a shell environment workspace for users and for heavy geo lifting by geoprocessing CLI commands
- is built and distributed with the computing resources provided by github and dockerhub.

See [`seasketch/geoprocessing-workspace` on Dockerhub](https://hub.docker.com/r/seasketch/geoprocessing-workspace)

## Packages and version numbers

Operating system:
* Ubuntu Focal 20.04 LTS with Python 3.9

Libraries:
```
PROJ_VERSION 8.0.1
GDAL_VERSION 3.3.1
SQLITE_VERSION 3.4
```

## GDAL

GDAL 3.3.1 is used because it supports flatgeobuf files, and works with flatgeobuf JS library v3.17.4 that geoprocessing lib is locked on for now

## Using the image directly

To run the GDAL command line utilities on local files, on data in the current working directory:

```bash
docker run --rm -it \
    --volume $(shell pwd)/:/data \
    seasketch/geoprocessing-workspace:latest \
    gdalinfo /data/your.tif
```

You can set it as an alias to save typing

```bash
function with-gp-base {
    docker run --rm -it --volume $(pwd)/:/data seasketch/geoprocessing-workspace:latest "$@"
}

with-gp-base gdalinfo /data/your.tif
```

## Using the Makefile

- `make` builds the image
- `make test` tests the image
- `make shell` gets you into a bash shell with the current working directory mounted at `/app`

## License

`docker-gp-workspace` source code and associated images on dockerhub available as **public domain**

Inspired by [perrygeo/docker-gdal-base](https://github.com/perrygeo/docker-gdal-base)