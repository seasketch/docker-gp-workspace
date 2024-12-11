# Docker image for seasketch geoprocessing workspace

The `docker-gp-workspace` repository builds and publishes a [Docker image](https://hub.docker.com/r/seasketch/geoprocessing-workspace) providing a stable [devcontainer workspace](https://github.com/seasketch/geoprocessing-devcontainer) for SeaSketch [geoprocessing](https://github.com/seasketch/geoprocessing) projects.

Features:

- uses Ubuntu LTS image
- includes common utilities for compiling software from source
- includes LTS version of Node
- includes conda (via miniconda) with a `base` environment that has Python and GDAL.  Users can adapt or create new environments
- includes awscli for deploying geoprocessing projects to AWS and working with them.
- can be used as a shell environment workspace for users and for heavy geo lifting by geoprocessing CLI commands
- is built and distributed with the computing resources provided by github and dockerhub.

## Usage

You should not need to work with this repository directly, unless you need to upgrade the `geoprocessing-workspace` image or extend it to meet your own needs.

### Upgrade

To upgrade the image:

- install and start Docker Desktop on your local system
- clone this repository locally and checkout the `dev` branch.
- make changes to the Dockerfile or related architecture-specific installer scripts
- run `make`
  - Builds a new Docker image.  You will need to have the `make` software package already installed.
  - this will build an image with the architecture of your system (`amd64` for `arm64`) and tags it as 'test', to differentiate it from any of the 'latest' images you might have installed.
- run `make shell`
  - starts a container using 'test' image (building it first if necessary), then opens a bash shell.  This is useful for testing that your Dockerfile changes are working as expected.
  - try running `node -v` or `gdalinfo` and make sure these commands output as expected.  You can go as far as to init a new geoprocessing project and make sure you can import a new dataset and run precalc.
- debugging
  - if the build is failing part way through your Dockerfile or architecture-specific script, a useful way to debug is to comment out the part of the build that is not working (and everything after it).  Then run `make` to build an image up to that point.  Then run `make shell` and run commands manually to figure out what is going wrong and how to fix it.  Once you get it working, update your Dockerfile or architecture-specific scripts with the updated commands, then uncomment and `make` to try and run a full build.  Keep doing this until you get to something that works.
- if your new image is looking ready
  - commit and push your changes to the dev branch.
  - The `publish unstable` Github action in `.github/workflows/publish-unstable.yml` will automatically trigger and publish a new container image with the `unstable` tag to [Docker Hub](https://hub.docker.com/r/seasketch/geoprocessing-workspace/tags).
  - Follow instructions for [unstable testing](https://seasketch.github.io/geoprocessing/docs/next/tutorials/upgrade/#upgrade-devcontainer) in the geoprocessing-devcontainer.
- if the unstable image is ready to go stable
  - Open a PR from the `dev` branch to `main` and merge it.  Do not squash commits.
  - One merge the `publish` Githunb action in `.github/workflows/publish.yml` will automatically trigger and publish a new container image with the `latest` tag.
  - Follow instructions for [testing](https://seasketch.github.io/geoprocessing/docs/next/tutorials/upgrade/#upgrade-devcontainer) in the geoprocessing-devcontainer.

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
