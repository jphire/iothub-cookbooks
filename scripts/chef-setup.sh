#!/bin/bash

# 
# Install ruby via rvm, and chef for automated setup scripts
# 


sudo apt-get install -y openssl ca-certificates curl wget git-core

curl -sSL https://rvm.io/mpapis.asc | gpg --import -


echo "INSTALLING RVM"
\curl -L https://get.rvm.io | bash -s stable --ruby=1.9.3

. ~/.rvm/scripts/rvm

rvm install 2.1.1

rvm --default use 1.9.3


echo "INSTALLING GEMS"
gem install chef --no-ri --no-rdoc

gem install knife-solo --no-ri --no-rdoc

sudo apt-get install -y libxslt-dev libxml2-dev

gem install berkshelf --no-ri --no-rdoc


echo "DONE"

