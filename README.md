cans.user-make
==============

[![Build Status](https://travis-ci.org/cans/user-make.svg?branch=master)](https://travis-ci.org/cans/user-make)
[![Ansible Galaxy](https://img.shields.io/badge/ansible--galaxy-cans.user--make-blue.svg?style=flat-square)](https://galaxy.ansible.com/cans/user-make)
[![License](https://img.shields.io/badge/license-GPLv2-brightgreen.svg?style=flat-square)](LICENSE)

Ansible role to create a bunch of users on target hosts


### How does it work ?

Each user to create has to be defined with an item as follows:

    - name: "johndoe"                (mandatory)
      gecos: "John Doe,,,"           (default: *omit*)
      groups: "sudo,adm"             (default: *omit*)
      ssh_key_create: false          (default: *true*)
      ssh_key_upload_to_ec2: true    (default: *usermake_ssh_key_upload_to_ec2*)
      ssh_key_download: true         (default: *usermake_ssh_key_download*)
      system: false                  (default: *false*)
      upload_my_key: false           (default: *usermake_upload_ssh_key_to_target*)
      remove: false                  (default: *omit* or *usermake_remove*)
      home_dir: "/home/jdoe"         (default: *usermake_home_base_dir/name*)

Here is the meaning of each varbiable found in the item:

- `name`: the login name to give to the new user;
- `gecos`: then [GECOS](https://en.wikipedia.org/wiki/Gecos_field) data
  to attach to the new user;
- `groups`: the list of groups the user should belong to. Groups listed
  here are supposed to exist *a priori* (cf. also the [next section](#cannotdo))
- `remove`: when the item *state* value is *'absent'* whether to remove the user's files when it is deleted,
  (default
- `ssh_key_create`: whether to generate a SSH key pair for the new user;
- `ssh_key_download`: whether to download the user's generated SSH
  public key to a folder on the local machine (see also the
  `usermake_ssh_key_download_dir` defined below).
- `ssh_key_upload_to_ec2`: whether to upload the user's generated SSH
  public key to AWS EC2 key management system.
- `state`: whether to create ) or delete () the user indicated with the
  values *'present'* or *'absent'* respectively (default: *'present'*);
- `system`: whether the user should be a system user (w. a low UID
  number and disabled login);
- `upload_my_key`: whether to upload your local ssh key to the target
  host.

All these values, if defined, will override the default define in the
[role variables](#role-variables) section below.


### What this role cannot do ? <a name="cannotdo"></a>

It cannot append users to new groups, it will override the user's groups
with the given list of group(s).


Requirements
------------

This role has no specific requirement.


Role Variables <a name="role-variables"></a>
--------------

All the variable names used in this role are namespaced with the prefix
`usermake_`.

- `usermake_home_base_dir`: let's you override the path of the directory
  where users home are created (default: `/home`);
- `usermake_remove`: whether to remove users home directory when they
  are deleted (default: *false*);
- `usermake_ssh_key_create`: whether to create an ssh key pair for the
  new users by default (default: *true*);
- `usermake_ssh_key_download`: whether to download created users' ssh
  keys locally;
- `usermake_ssh_key_download_dir`: the directory where to store downloaded
  public SSH keys (default: *`collected-keys`*);
- `usermake_ssh_key_download_dir_mode`: the mode of the directory where
  to store downloaded public SSH keys (default: *0750*);
- `usermake_ssh_key_passphrase`: the default passphrases to encrypt ssh
  private keys. It is not recommanded to rely on this. You should provide
  passphrases by other means. (default: *omit* [no passphrase]);
- `usermake_system`: whether the create users should be system users
  by default (default: *false*);
- `usermake_upload_ssh_key_to_target`: whether to upload the local user's
  SSH public key to the target host. Useful if you plan to perform tasks
  as that user in the next tasks or roles of your playbook (default: *true*);
- `usermake_upload_ssh_key_file`: when `usermake_upload_ssh_key_to_target`
  or a user's item `upload_my_key` value is `true`, points to the file where
  read the public key to upload (default: *~/.ssh/id_rsa.pub*);
- `usermake_user_groups`: the groups to assign the created users to by
  default (default: *omit*);
- `usermake_users`: the list of users to create, defined with items as
  described above (default: *[]*);


Dependencies
------------

This role has no dependency


Example Playbook
----------------

Creating some users:

    - hosts: servers
      roles:
         - role: cans.user-make
           usermake_users:
             - name: "alice"
               groups: "sudo,adm"
               system: "no"
               ssh_key_create: "yes"
             - name: "bob"
               gecos: "Bob no sponge,,,"
               system: "yes"
               ssh_key_create: true

Deleting some users:

    - hosts: servers
      roles:
        - role: cans.user-make
          usermake_users:
            - name: "alice"
              state: "absent"
              remove: true  # Remove all users files
            - name: "bob"
              state: 

You might also want to have a look at the tests found in
`tests/test.yml` for more usage examples of this role.


License
-------

GPLv2


Author Information
------------------

Copyright © 2017, Nicolas CANIART.
