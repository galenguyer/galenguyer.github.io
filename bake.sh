#!/usr/bin/env bash
# build, tag, and push docker images

# exit if a command fails
set -o errexit

# exit if required variables aren't set
set -o nounset

# check for docker
if command -v docker 2>&1 >/dev/null; then
	echo "using docker..."
else
	echo "could not find docker, exiting"
	exit 1
fi

# if no registry is provided, tag image as "local" registry
registry="${REGISTRY:-local}"
echo "using registry $registry..."

# get git revision
git_ver="$(git rev-parse --short HEAD)"
echo "on git revision $git_ver..."

if [[ "$#" -eq 1 ]]; then
	if [[ "$1" = "files" ]] && [[ -e ./_site ]]; then
		echo "removing ./_site"
		rm -r ./_site
	fi
fi

export REGISTRY="$registry"
docker buildx bake "$@"

if [ "$registry" != "local" ]; then
  docker push "$registry/galenguyer.com"
  docker tag "$registry/galenguyer.com" "$registry/galenguyer.com:$git_ver"
  docker push "$registry/galenguyer.com:$git_ver"
fi
