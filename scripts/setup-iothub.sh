#!/bin/bash

# Installs iothub Kahvihub implementation, and starts
# the server

DIRNAME="kahvihub"
GITREPO="https://github.com/uh-cs-iotlab/kahvihub.git"


if [ ! -d "$DIRNAME" ]; then
  echo "Cloning IoT Hub from $GITREPO"
  git clone "$GITREPO"
else
  echo "Using local $DIRNAME directory"
fi

cd "$DIRNAME"

echo "Building IoT Hub.."
make embedded.test
echo "Done"

echo "Starting IoT Hub.."
make embedded.test.run &> /dev/null & 

echo "Done"
