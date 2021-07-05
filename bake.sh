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

if [[ "$#" -eq 1 ]]; then
	if [[ "$1" = "files" ]]; then
		echo "removing ./_site"
		rm -r ./_site
	fi
fi

docker buildx bake "$@"
