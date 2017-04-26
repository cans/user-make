#!/bin/sh
prompt="${1:-Password: }"
env python -c "from passlib.hash import sha512_crypt; import getpass; print sha512_crypt.using(rounds=5000).hash(getpass.getpass('${prompt}'))"
