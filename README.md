# Mozilla Firefox Cookbook

[![Cookbook Version](http://img.shields.io/cookbook/v/mozilla_firefox.svg?style=flat-square)][cookbook]
[![Build Status](http://img.shields.io/travis/dhoer/chef-mozilla_firefox.svg?style=flat-square)][travis]

[cookbook]: https://supermarket.chef.io/cookbooks/mozilla_firefox
[travis]: https://travis-ci.org/dhoer/chef-mozilla_firefox

This cookbook installs the latest version of Firefox by default. 
On Mac OS X and Windows you can also specify a specific version, e.g. `42.0` 
and select a specific language with `en-US` being the default.
 
A `firefox_version` method is also available to retrieve exact version installed.

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

Include the default recipe on a node's runlist to ensure that Firefox is installed.

The following example retrieves the version installed by using `firefox_version` method:

```ruby
v = firefox_version
```

**Tip:** use `allow_any_instance_of` to stub firefox_version method when testing with rspec:

```ruby
allow_any_instance_of(Chef::Recipe).to receive(:firefox_version).and_return('42.0')
```

### Attributes
* `node['mozilla_firefox']['version']` - Install latest or specific version. 
Mac OS X and Windows only (Linux uses package manager). Default is `latest`.
* `node['mozilla_firefox']['lang']` - Language of firefox to install.  Windows and Mac OS X only. Default is `en-US`.
* `node['mozilla_firefox']['releases_url']` - URL for the releases directory. Windows and Mac OS X only.
* `node['mozilla_firefox']['32bit_only']` - Install 32-bit browser on 64-bit machines.  
Windows only for Firefox 42.0 or higher. Default is `false`.

## Getting Help
* Ask specific questions on [Stack Overflow](http://stackoverflow.com/questions/tagged/firefox).
* Report bugs and discuss potential features in [Github issues](https://github.com/dhoer/chef-mozilla_firefox/issues).

## Contributing

Please refer to [CONTRIBUTING](https://github.com/dhoer/chef-mozilla_firefox/blob/master/CONTRIBUTING.md).

## License

MIT - see the accompanying [LICENSE](https://github.com/dhoer/chef-mozilla_firefox/blob/master/LICENSE.md) 
file for details.
