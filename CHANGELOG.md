# CHANGELOG

## 3.0.1 2017-06-12

- Allow for non-package manager installs on all linux platforms
- Drop support for CentOS 5

## 3.0.0 2017-03-24

- Rename retries attribute to attempts to be Chef 13 compatible
- Removed 32bit_only attribute (use force_32bit instead)
- Default Ubuntu to using package manager

## 2.1.1 2017-02-04

- Fix #13 firefox_version throws exception on macosx

## 2.1.0 2017-01-28

- Replace iceweasel package with firefox-esr on debian platform
- Ubuntu no longer defaults to using package manager

## 2.0.0 2016-10-01

- Drop support for Chef 11

## 1.2.4 2016-09-23

- Fix #10 Recipe fails on x64 install
- Fix #8 Remove carriage return characters from firefox_version
- Fix #7 Retry (up to 5 times) when download fails

## 1.2.3 2016-09-21

- Fix system cannot find the path specified on Windows

## 1.2.2 2016-09-21

- Fix 'firefox' is not recognized as an internal or external command on Windows

## 1.2.1 2016-09-20

- Fix #6 Firefox no longer installing causing Recipe compile error

## 1.2.0 2016-09-03

- Allow for multiple version installs 
- Add experimental non-package install for Linux - only Ubuntu platform works at this time

## 1.1.1 2016-07-11

- Fix #4 Windows ESR versions always re-install

## 1.1.0 2016-03-21

- Fix #2 Change default version from latest to latest-esr

## 1.0.1 2015-11-18

- Fix #1 Chef 11 throws EOFError

## 1.0.0 2015-11-18

- Initial release
