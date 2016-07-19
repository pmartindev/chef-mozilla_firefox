# Mozilla Firefox Cookbook

[![Cookbook Version](http://img.shields.io/cookbook/v/mozilla_firefox.svg?style=flat-square)][cookbook]
[![linux](http://img.shields.io/travis/dhoer/chef-mozilla_firefox/master.svg?label=linux&style=flat-square)][linux]
[![osx](http://img.shields.io/travis/dhoer/chef-mozilla_firefox/macosx.svg?label=macosx&style=flat-square)][osx]
[![win](https://img.shields.io/appveyor/ci/dhoer/chef-mozilla-firefox/master.svg?label=windows&style=flat-square)][win]

[cookbook]: https://supermarket.chef.io/cookbooks/mozilla_firefox
[linux]: https://travis-ci.org/dhoer/chef-mozilla_firefox/branches
[osx]: https://travis-ci.org/dhoer/chef-mozilla_firefox/branches
[win]: https://ci.appveyor.com/project/dhoer/chef-mozilla-firefox 

This cookbook installs Firefox browser downloaded directly from 
[Mozilla](https://download-installer.cdn.mozilla.net/pub/firefox/releases/latest/README.txt) 
where you can specify version (e.g., `latest`, `latest-esr`, `latest-beta`, `42.0`, `38.4.0esr`, or `43.0b4`)
and language with `latest-esr`and `en-US` being the defaults.

Linux platforms can choose to use the package manager instead by setting `use_package_manager` to true. Note that 
version and lang are ignored.
 
A `firefox_version` method is also available to retrieve the default version installed.

## Requirements

Chef 11+

### Platforms
* CentOS/RHEL
* Debian
* Mac OS X
* Ubuntu
* Windows

### Cookbooks
* windows
* dmg

## Usage

Include default recipe in a cookbook or a run list to install Firefox browser.

The following example retrieves the default installed version by using `firefox_version` method:

```ruby
v = firefox_version
```

**Tip:** use `allow_any_instance_of` to stub firefox_version method when testing with rspec:

```ruby
allow_any_instance_of(Chef::Recipe).to receive(:firefox_version).and_return('42.0')
```

### Attributes
* `node['mozilla_firefox']['version']` - Install `latest`, `latest-esr`, `latest-beta`, or specific version 
e.g., `42.0`, `38.4.0esr`, or `43.0b4`. Ignored on Linux platforms when `use_package_manager` is true. 
Default is `latest-esr`.
* `node['mozilla_firefox']['lang']` - Language desired. Ignored on Linux platforms when `use_package_manager` 
is true.  Default is `en-US`.
* `node['mozilla_firefox']['32bit_only']` - DEPRECATED! This will be dropped in next major release, use `x86_only`
instead.
* `node['mozilla_firefox']['x86_only']` - Install 32-bit browser on 64-bit machines. Linux and Windows platforms 
only. Default is `false`.
* `node['mozilla_firefox']['use_package_manager']` - Install using apt or yum package manager. Linux platform only. 
Default is `false`.
* `node['mozilla_firefox']['packages']` - Dependency packages. Linux platform only. Default is 
`%w(libasound2 libgtk2.0-0 libdbus-glib-1-2 libxt6)`.


# Resources

## mozilla_firefox

### Attributes
* `version` - Install `latest`, `latest-esr`, `latest-beta`, or specific version e.g., `42.0`, `38.4.0esr`, or `43.0b4`. 
Ignored on Linux platforms when `use_package_manager` is true. 
* `checksum` - SHA256 Checksum of the file. Not required.
* `lang` - Language desired. Ignored on Linux platforms when `use_package_manager` is true.  Default is `en-US`.
* `path` - Path to install Firefox. Defaults to: /opt/firefox/#{version}_#{language}
splay - Time in minutes to wait before next contact to Mozilla servers. Not required, defaults to 0 (zero) seconds.
link - Create the specfied symlink (Linux Only). This can be an array to create multiple symlinks to the same instance, or a string for a single symlink.


attribute(:version, kind_of: String, name_attribute: true)
attribute(:checksum, kind_of: String)
attribute(:lang, kind_of: String, default: lazy { node['mozilla_firefox']['lang'] })
attribute(:x86_only, kind_of: [TrueClass, FalseClass], default: lazy { node['mozilla_firefox']['x86_only'] })
attribute(:use_package_manager, kind_of: [TrueClass, FalseClass],
                                default: lazy { node['mozilla_firefox']['use_package_manager'] })
attribute(:path, kind_of: [String, NilClass])
attribute(:link, kind_of: [String, Array, NilClass])
attribute(:packages, kind_of: [Array, NilClass], default: lazy { node['mozilla_firefox']['packages'] })
attribute(:windows_ini_source, kind_of: String, default: 'windows.ini.erb')
attribute(:windows_ini_content, kind_of: String, default: lazy { { InstallDirectoryPath: :path } })
attribute(:windows_ini_cookbook, kind_of: String, default: 'mozilla_firefox')

## Getting Help
* Ask specific questions on [Stack Overflow](http://stackoverflow.com/questions/tagged/firefox).
* Report bugs and discuss potential features in [Github issues](https://github.com/dhoer/chef-mozilla_firefox/issues).

## Contributing

Please refer to [CONTRIBUTING](https://github.com/dhoer/chef-mozilla_firefox/blob/master/CONTRIBUTING.md).

## License

MIT - see the accompanying [LICENSE](https://github.com/dhoer/chef-mozilla_firefox/blob/master/LICENSE.md) 
file for details.
