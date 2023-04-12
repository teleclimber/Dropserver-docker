#!/usr/bin/env bash

source config.sh

usage='script usage:
-a builds the ds-host-bin image
-b builds the ds-host image
-p pushes to docker hub
-l tags new image as latest'

while getopts 'ablph' OPTION; do
  case "$OPTION" in
    a)
      build_bin=true
      ;;
    b)
      build=true
      ;;
    p)
      push=true
      ;;
    l)
      latest=true
      ;;
	  h)
      echo "$usage" >&2
      exit 1
      ;;
    ?)
      echo "$usage" >&2
      exit 1
      ;;
  esac
done

if [ -e $build_bin ] && [ -e $build ] && [ -e $push ] ; then
	echo "$usage" >&2
    exit 1
fi

if [ -e $push ] && [ "$latest" = true ] ; then
	echo "Latest (-l) has no effect if Push (-p) is not set. Try again." >&2
    exit 1
fi

if [ "$build_bin" = true ] ; then
	docker build \
		-t $ds_host_bin_repo:$ds_host_ver \
		-f bin.dockerfile \
		--build-arg DS_HOST_VERSION=$ds_host_ver \
		.

	if [ "$push" = true ] ; then
		docker push $ds_host_bin_repo:$ds_host_ver
	fi
fi

if [ "$build" = true ] ; then
	docker build \
		-t $ds_host_repo:$ds_host_ver \
		--build-arg DS_HOST_VERSION=$ds_host_ver \
		--build-arg DENO_VERSION=$deno_ver \
		--build-arg BASE_IMAGE=$base_img \
		.
fi

if [ "$push" = true ] ; then
	docker push $ds_host_repo:$ds_host_ver
	if [ "$latest" = true ] ; then
		docker tag $ds_host_repo:$ds_host_ver $ds_host_repo:latest
		docker push $ds_host_repo:latest
	fi
fi
