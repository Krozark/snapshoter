snapshot
========

A script that make snapshot of a running program


Requirement
-----------

* criu : http://criu.org/Main_Page
* Linux kernel 3.9+


usage
-----

auto save

user@host:~path$ sudo snapshoter.sh -p pid -t timeout -l limit


to restore, use criu as:

user@host:~path$ cd dir
user@host:~path$ sudo criu restore --shell-job

