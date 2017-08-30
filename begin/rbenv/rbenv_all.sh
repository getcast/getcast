#!/bin/bash

# parameters
RBENV_ROOT=$1

# create script file if it doesn't exist
if [ ! -f "/etc/profile.d/rbenv.sh" ]; then
	cat >"/etc/profile.d/rbenv.sh" <<EOL
if id -Gn | grep &>/dev/null '\\b$GROUPS\\b'; then
	export RBENV_ROOT=$RBENV_ROOT
	export PATH="\$RBENV_ROOT/bin:\$PATH"
	eval "\$(rbenv init -)"
fi
EOL
fi