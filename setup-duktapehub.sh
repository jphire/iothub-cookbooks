# !/bin/bash

# NodeJS installation for benchmarking
echo "Installing NodeJS"
curl -sL https://deb.nodesource.com/setup | bash -
apt-get install -y nodejs

DIRNAME="node-test-server"
GITREPO="https://github.com/jphire/node-test-server.git"

if [ ! -d "$DIRNAME" ]; then
  echo "Cloning Node Hub from $GITREPO"
  git clone "$GITREPO"
else
  echo "Using local $DIRNAME directory"
fi

cd "$DIRNAME"

sudo npm install --no-bin-links

node duktape-server.js &
