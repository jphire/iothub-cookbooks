# !/bin/bash

# NodeJS installation for benchmarking
echo "Installing NodeJS"
curl -sL https://deb.nodesource.com/setup | bash -
apt-get install -y nodejs

DIRNAME="node-iothub"
GITREPO="https://github.com/uh-cs-iotlab/node-iothub.git"

if [ ! -d "$DIRNAME" ]; then
  echo "Cloning Node Hub from $GITREPO"
  git clone "$GITREPO"
else
  echo "Using local $DIRNAME directory"
fi

cd "$DIRNAME"

sudo npm install --no-bin-links

node server.js &
