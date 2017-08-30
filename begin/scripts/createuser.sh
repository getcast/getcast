#!/bin/bash
sudo -u postgres bash -c "psql -c \"CREATE USER getcast WITH PASSWORD 'marvelouspandaband' CREATEDB;\""
