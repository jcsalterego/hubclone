hubclone - Clone GitHub repositories
====================================

Clones GitHub repository by username

Requirements
============

curl and git.

Quick Start
===========

Clone the repository:

    $ git clone git://github.com/jcsalterego/hubclone.git
    $ alias hubclone="`pwd`/hubclone/hubclone.sh";

Installation
============

For a more permanent installation, add the alias to your .profile:

    alias hubclone='/path/to/hubclone/hubclone.sh';

Usage
=====

Provide a username and it will create a subdirectory and populate it with all the available public repositories.  If the repository directories exist, it will attempt to pull the latest.

    $ hubclone defunkt
      ...
    $ tree
    .
    `-- defunkt
        |-- Mustache.tmbundle
        |-- acts_as_textiled
        |-- ...
        `-- zippy

Options
=======

`-n`, `--dry-run` : Print the commands as they would be run.
