#!/bin/bash

set +e

export FULL_VERSION=`git describe --tags --abbrev=1`
export VERSION=${FULL_VERSION}

ansible-playbook --vault-password-file=~/.ansiblevaultpassfile \
                 deploy/node-walletconnect-push.yml \
                 -i deploy/inventories/production \
                 -l walletconnect
