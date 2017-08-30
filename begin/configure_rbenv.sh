#!/bin/bash

## install and configure rbenv ##

# rbenv root directory
RBENV_ROOT=/usr/local/rbenv

# script for loading rbenv into PATh
RBENV_INIT=rbenv.sh

# rbenv group name
GROUP=staff

# clone rbenv from repository
git clone git://github.com/rbenv/rbenv.git "$RBENV_ROOT"

# give permissions to group
chgrp -R "$GROUP" "$RBENV_ROOT"
chmod -R g+rwxXs "$RBENV_ROOT"

# set environment variables for all users
sh rbenv/rbenv_all.sh "$RBENV_ROOT"

## install and configure ruby-build plugin ##

# create plugin directory
mkdir "$RBENV_ROOT/plugins"

# clone ruby-build from repository
git clone git://github.com/rbenv/ruby-build.git "$RBENV_ROOT/plugins/ruby-build"

# give permissions to group
chgrp -R "$GROUP" "$RBENV_ROOT/plugins/ruby-build"
chgrp -R g+rwxs "$RBENV_ROOT/plugins/ruby-build"

# update changes to current shell
source /etc/profile