#!/bin/bash

# create user with db creation privileges
sudo -u postgres bash -c "psql -c \"CREATE USER getcast WITH PASSWORD 'marvelouspandaband' CREATEDB;\""
