#!/bin/bash

## install and configure rbenv ##
if [ "$1" == '--user' ]; then
	INSTALL_MODE=user
else
	INSTALL_MODE=system
fi

# rbenv root directory
if [ "$INSTALL_MODE" == "user" ]; then
	RBENV_ROOT=$HOME/.rbenv
else	
	RBENV_ROOT=/usr/local/rbenv
fi

# rbenv group name
GROUP=staff

# clone rbenv from repository
git clone git://github.com/rbenv/rbenv.git "$RBENV_ROOT"

## install and configure ruby-build plugin ##

# create plugin directory
mkdir "$RBENV_ROOT/plugins"

# clone ruby-build from repository
git clone git://github.com/rbenv/ruby-build.git "$RBENV_ROOT/plugins/ruby-build"

## set up permissions ##

# give permissions to group
if [ "$INSTALL_MODE" == "system"]; then
	chgrp -R "$GROUP" "$RBENV_ROOT"
	chmod -R g+rwxXs "$RBENV_ROOT"
fi

# set environment variables and update changes to current shell
rbenv/rbenv_envvar.sh "$RBENV_ROOT" "$GROUP" $*