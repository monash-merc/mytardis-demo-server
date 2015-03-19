# mytardis-demo-server
MyTardis Demo Server used by MyData documentation

See: https://github.com/monash-merc/mytardis-demo-server/releases

Referenced by: http://mydata.readthedocs.org/en/latest/mydata-tutorial-with-mytardis-demo-server.html

Designed to be an easy double-click install method to try a demo version of MyTardis,
the target audience being users who want to try MyData using a local MyTardis server
(http://127.0.0.1:8000), and have all of the Python dependencies installed automatically.
See the MyData documentation (link above) for how to use MyData to upload data into this
MyTardis demo server.

Only available for Windows at the moment.

A Mac OS X version can be provided if there is sufficient interest.  The basic approach
would be to download the Python 2.7.9 source tarball from Python.Org, build it using 
./configure --prefix=/build/mytardis-demo-server/Python-2.7.9; make; make install,
and install all of MyTardis's Python module dependencies within that Python tree, and
to include an appropriate MyTardis version in /build/mytardis-demo-server/[MyTardis-version]/
and then package everything up in a DMG for distribution.  Scripts (applescripts?)
should be included to assist with opening a Terminal with the necessary environment
variables set so that the Python version we include appears first in the PATH. 
