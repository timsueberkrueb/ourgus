## OurGUS

[![License](https://img.shields.io/badge/license-GPLv3.0-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.html)
[![GitHub release](https://img.shields.io/github/release/tim-sueberkrueb/ourgus.svg)](https://github.com/tim-sueberkrueb/ourgus/releases)
[![Build Status](https://travis-ci.org/tim-sueberkrueb/ourgus.svg?branch=develop)](https://travis-ci.org/tim-sueberkrueb/ourgus)
[![GitHub issues](https://img.shields.io/github/issues/tim-sueberkrueb/ourgus.svg)](https://github.com/tim-sueberkrueb/ourgus/issues)
[![Maintained](https://img.shields.io/maintenance/yes/2017.svg)](https://github.com/tim-sueberkrueb/ourgus/commits/develop)

Unofficial Gymnasium Unterrieden Sindelfingen (GUS) application.

### Dependencies
* Qt >= 5.10 with at least the following modules is required:
    * [qtbase](http://code.qt.io/cgit/qt/qtbase.git)
    * [qtdeclarative](http://code.qt.io/cgit/qt/qtdeclarative.git)
    * [qtquickcontrols2](http://code.qt.io/cgit/qt/qtquickcontrols2.git/)
    * [qtgraphicaleffects](http://code.qt.io/cgit/qt/qtgraphicaleffects.git)
    * [qtwebengine](http://code.qt.io/cgit/qt/qtwebengine.git) (Desktop) or [qtwebview](http://code.qt.io/cgit/qt/qtwebview.git) (Android)

The following modules and their dependencies are required:
* [Fluid](https://github.com/lirios/fluid) == 1.0.0

### Build

```sh
mkdir build && cd build
qmake ..
make
```

### Credits
This application accesses [@DominikStiller](https://github.com/DominikStiller)'s [Vertretungsplan](https://github.com/DominikStiller/Vertretungsplan) api.
The application icon was created by Hendrik Süberkrüb.

### License
Licensed under the terms of the GNU General Public License version 3 or, at your option, any later version.
