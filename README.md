# Mozilla Firefox Cookbook

[![Cookbook Version](http://img.shields.io/cookbook/v/mozilla_firefox.svg?style=flat-square)][cookbook]
[![Build Status](http://img.shields.io/travis/dhoer/chef-mozilla_firefox.svg?style=flat-square)][travis]

[cookbook]: https://supermarket.chef.io/cookbooks/mozilla_firefox
[travis]: https://travis-ci.org/dhoer/chef-mozilla_firefox

This cookbook installs Firefox browser. Mac OS X and Windows download directly from 
Mozilla where you can specify version (e.g., `latest`, `latest-esr`, `latest-beta`, `42.0`, `38.4.0esr`, or `43.0b4`)
and language with `latest-esr`and `en-US` being the defaults.
Linux platforms only use the package manager at this time.
 
A `firefox_version` method is also available to retrieve the version installed.

## Requirements

Chef 11+

### Platforms
* CentOS/RHEL
* Debian (Mozilla Iceweasel)
* Mac OS X
* Ubuntu
* Windows

### Cookbooks
* windows
* dmg

## Usage

Include default recipe in a cookbook or a run list to install Firefox browser.

The following example retrieves version installed by using `firefox_version` method:

```ruby
v = firefox_version
```

**Tip:** use `allow_any_instance_of` to stub firefox_version method when testing with rspec:

```ruby
allow_any_instance_of(Chef::Recipe).to receive(:firefox_version).and_return('42.0')
```

### Attributes
* `node['mozilla_firefox']['version']` - Install `latest`, `latest-esr`, `latest-beta`, or specific version 
e.g., `42.0`, `38.4.0esr`, or `43.0b4`. 
Mac OS X and Windows only (Linux platforms use the package manager). Default is `latest-esr`.
* `node['mozilla_firefox']['lang']` - Language to install.  Windows and Mac OS X only. Default is `en-US`.
* `node['mozilla_firefox']['32bit_only']` - Install 32-bit browser on 64-bit machines. Windows only. Default is `false`.

## Getting Help
* Ask specific questions on [Stack Overflow](http://stackoverflow.com/questions/tagged/firefox).
* Report bugs and discuss potential features in [Github issues](https://github.com/dhoer/chef-mozilla_firefox/issues).

## Contributing

Please refer to [CONTRIBUTING](https://github.com/dhoer/chef-mozilla_firefox/blob/master/CONTRIBUTING.md).

## License

MIT - see the accompanying [LICENSE](https://github.com/dhoer/chef-mozilla_firefox/blob/master/LICENSE.md) 
file for details.
