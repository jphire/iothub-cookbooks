# !/bin/bash

# NodeJS installation for benchmarking
echo "Installing NodeJS"
curl -sL https://deb.nodesource.com/setup_4.x | sudo bash -
sudo apt-get install -y nodejs

DIRNAME="node-iothub"
GITREPO="https://github.com/uh-cs-iotlab/node-iothub.git"

if [ ! -d "$DIRNAME" ]; then
  echo "Cloning Node Hub from $GITREPO"
  git clone "$GITREPO"
else
  echo "Using local $DIRNAME directory"
fi

cd "$DIRNAME"

git checkout advance-executable-feed

sudo npm install --no-bin-links

sudo echo "{ \
  \"username\": \"janne\", \
  \"email\": \"jjaukka@cs.helsinki.fi\", \
  \"password\": \"janne\" \
}" >admin-creds.json


sudo node . &
