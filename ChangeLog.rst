Change Log
==========

This log tracks all notable changes made to the ``cans.user-make`` role
for Ansible.

The format is based on `Keep a Changelog <http://keepachangelog.com/en/1.0.0/>`_
and this project adheres to `Semantic Versioning <http://semver.org/spec/v2.0.0.html>`_.


Unreleased
----------

Added:
~~~~~~

* Added


Changed:
~~~~~~~~

Fixed:
~~~~~~

* Fixed 


Version v1.1.2 -- 2018-02-20
----------------------------

Fixed:
~~~~~~

* Role when used with user delegation would also delegate local tasks
  to that user (issue #6)


Version v1.1.1 -- 2018-02-17
----------------------------

Fixed:
~~~~~~

* Role would always try to upload the local user's key to the newly
  created remote user account, even if asked not to (issue #4);


Version v1.1.0 -- 2018-02-16
----------------------------

Added:
~~~~~~

* Ability to create sudo users;


Version v1.0.0 -- 2017-02-16
----------------------------

Added:
~~~~~~

* initial release, includes basic functionalities;
