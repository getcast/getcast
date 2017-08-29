#!/bin/bash

# add apt-repository to sources.list.d
echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -c -s)-pgdg main" >> /etc/apt/sources.list.d/pdgd.list

# get signing key
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

# update package lists
sudo apt update

# install postgres
sudo apt install \
  postgresql-9.6 \
  postgresql-client-9.6 \
  postgresql-contrib-9.6 \
  postgresql-server-dev-9.6 \
  libpq-dev

echo 'perform following commands:'
echo
echo '## create postgres user'
echo 'sudo su - postgres'
echo 'createuser --pwprompt [username]'
echo
echo '## modify env files'
echo '#.env_development'
echo 'DATABASE_URL="postgresql://[username]:[password]@localhost/getcast_development"'
echo '#.env_test'
echo 'DATABASE_URL="postgresql://[username]:[password]@localhost/getcast_test"'

# start postgresql
service postgresql start

# check that postgres is running properly
if netstat -an 5432 | grep &>/dev/null 'postgres'; then
	echo '[OK] postgres running on port 5432!'
else
	echo '[ERR] could not find postgres at port 5432! check your /etc/postgres/9.6/main/postgres.conf'
fi