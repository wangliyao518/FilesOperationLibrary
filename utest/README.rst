[![Build Status](https://travis-ci.org/wangliyao518/FilesOperationLibrary?branch=master)](https://travis-ci.org/wangliyao518/FilesOperationLibrary)
[![Coverage Status](https://coveralls.io/repos/github/nokia/moler/badge.svg?branch=master)](https://coveralls.io/github/nokia/moler?branch=master)
[![BCH compliance](https://bettercodehub.com/edge/badge/nokia/moler?branch=master)](https://bettercodehub.com/)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/355afc9110f34d549b7c08c33961827c)](https://www.codacy.com/app/mplichta/moler?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=nokia/moler&amp;utm_campaign=Badge_Grade)
[![License](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)](./LICENSE)

============
Requirements
------------
Before running the test, install the dependencies::

    pip install -r requirements.cfg

Unit Tests
----------
Units tests are written by using the Python default `unittest`_ framework.
Unit test can be executed by running::

    python utest/run.py

The utest directory contains everything needed to run SeleniumLibrary unit tests.
This includes:

- Unit test in `test` folder.
- Unit test runner: `run.py`

Unit test are executed using the interpreter which starts the `run.py` script.

ApprovalTests
-------------
For unit test, it is possible to use `ApprovalTests`_ framework. ApprovalTests
provides an easy and visual way to compare strings in unit tests. For more
details, please read `ApprovalTests`_ documentation and `ApprovalTests blog post`_.
The downside of ApprovalTests is that it does not work when using `Jython`_
as an interpreter. Therefore all unit tests using ApprovalTests imports
must handled with `try/except ImportError:` and skipped with:
`@unittest.skipIf(JYTHON, 'ApprovalTest does not work with Jython')`. The `JYTHON` is
imported from `from robot.utils import JYTHON`


.. _unittest: https://docs.python.org/3/library/unittest.html
.. _ApprovalTests: https://github.com/approvals/ApprovalTests.Python
.. _ApprovalTests blog post: http://blog.approvaltests.com/
.. _Jython: http://www.jython.org/
