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

# create script file if it doesn't exist
if [ ! -f "scripts/$RBENV_INIT" ]; then
	cat >"scripts/$RBENV_INIT" <<EOL
if id -Gn | grep &>/dev/null '\\b$GROUPS\\b'; then
	export RBENV_ROOT=$RBENV_ROOT
	export PATH="\$RBENV_ROOT/bin:\$PATH"
	eval "\$(rbenv init -)"
fi
EOL
fi

# copy it to /etc/profile.d to set for all users
cp "scripts/$RBENV_INIT" "/etc/profile.d/$RBENV_INIT"


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