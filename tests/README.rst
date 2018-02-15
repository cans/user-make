Running the tests
=================

If you want to run the tests locally, you will need to:


- Put yourself inside the root directory of this project, that is
  the parent directory of the on containing this file::

    $ cd path/to/user-make

- create a new virtualenv for this project::

    $ module="$([ '2' = "`python --version 2>&1 | cut -f 2 -d \  | head -c 1`" ] && echo 'virtualenv' || echo 'venv'
    $ python -m "${module}" ansible-role-testing

  Or, if you use virtualenvwrappers::

    $ mkvirtualenv -a . -r tests/requirements.txt ansible-role-testing

- Install the Python requirements (*cf.* the requirements.txt file)
  from PyPI (no needed if you use ``mkvirtualenv`` as shown above)::

    $ pip install -r requirements.txt

- Setup docker on your system (*cf.* _[#])
- Install the roles required by the test-runner playbook (local.yml)::

    $ ansible-galaxy install -r tests/requirements.yml -p tests/roles

- Run the tests::

    $ ansible-playbook tests/local.yml


The test suite itself is in the ``tests/test.yml`` playbook. The 
``local.yml`` playbook is just here to bootstrap a docker container
in which run the tests, so you don't mess your machine's configuration
testing this role. You'll just mess the docker container instance.


A note on Debian systems
------------------------

Installing docker from the distribution package dos not alwasy work.
You may need to deinstall those packages (``docker.io``, ``docker-runc``,
docker-containerd, ...) and install the one provided by docker:
``docker-ce`` _[1]

A second issue (may not be Debian specific) it seem Ansible has issues
with virtualenvs. It cannot find the ``docker-py`` module despite it
being properly installed in the virtualenv. In that case you will need
to install it, either globally or on your personnal account if the
later is not an option::

    # apt-get install python-docker

Or::

    $ pip install --user docker-py   # That option has yet to be tested.



.. [#] See https://docs.docker.com/install/linux/docker-ce/debian/#install-docker-ce-1
