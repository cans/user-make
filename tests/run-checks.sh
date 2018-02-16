#!/bin/sh
###
# Small script to run most basic checks locally.
###
basedir="$(cd `dirname ${0}`; pwd)"
cd "${basedir}"

cat > ansible.cfg <<HERE
[defaults]
roles_path = ../../
HERE
ansible-playbook test.yml --syntax-check
ansible-lint test.yml || true

rm ./ansible.cfg

