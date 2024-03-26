#!/usr/bin/env bash
#

if [ ! -d $HOME/.dev-env  ]; then
      mkdir -p $HOME/.dev-env/workspace;
fi

# Run dev-env docker container
docker run -i -t \
    -p 2222:22 \
    -v /var/run/docker.sock:/var/run/docker.sock:rw \
    -v $HOME/.dev-env/workspace:/workspace:rw \
    dev-env:latest
