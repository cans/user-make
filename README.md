cans.user-make
==============

Ansible role to create a bunch of users on target hosts


### How does it work

Each user to create has to be defined with an item as follows:

    - name: "johndoe"
      gecos: "John Doe,,,"    (default: "")
      groups: "sudo,adm"      (default: "")
      system: "yes"           (default: *"no"*)
      create_keypair: "no"    (default: *"yes"*)


Here is the meaning of each varbiable found in the item:

- `name`: the login name to give to the new user;
- `gecos`: then [GECOS](https://en.wikipedia.org/wiki/Gecos_field) data
  to attach to the new user;
- `groups`: the list of groups the user should belong to. Groups listed
  here are supposed to exist *a priori* (cf. also the [next section](#cannotdo))
- `system`: whether the user should be a system user (w. a low UID and
  disabled login);
-


### What this role cannot do: <a name="cannotdo"></a>

- it cannot append users to new groups, it will override the user's one
  with the given list of group(s)

Requirements
------------

This roles has no specific requirements.


Role Variables
--------------

- `user_make_home_base_dir`: let's you override the path of the directory
   where users home are created (default: `/home`)
- `user_make_ssh_key_passphrase`: the default passphrases to encrypt ssh
   private keys. It is not recommanded to rely on this. You should
   provide passphrases by other means. (default: `` [empty string])
- `user_make_add`: the list of users to create, defined with items as described
  above;


Dependencies
------------

This role has no dependency


Example Playbook
----------------

Creating some users:


    - hosts: servers
      roles:
         - role: cans.user-make
           user_make_add:
             - name: "alice"
               groups: "sudo,adm"
               system: "no"
               create_keypair: "yes"
             - name: "bob"
               gecos: "Bob no sponge,,,"
               system: "yes"
               create_keypair: "no"

License
-------

GPLv2


Author Information
------------------

Copyright © 2017, Nicolas CANIART.
