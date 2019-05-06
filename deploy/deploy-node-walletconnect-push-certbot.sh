#!/bin/bash

ansible-playbook --vault-password-file=~/.ansiblevaultpassfile node-walletconnect-push-certbot.yml -i inventories/production -l walletconnect
