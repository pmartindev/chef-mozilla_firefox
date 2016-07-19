default['mozilla_firefox']['version'] = 'latest-esr'
default['mozilla_firefox']['lang'] = 'en-US'
default['mozilla_firefox']['32bit_only'] = false # DEPRECATED: will be dropped in next major release, use x86_only
default['mozilla_firefox']['x86_only'] = node['mozilla_firefox']['32bit_only']
default['mozilla_firefox']['use_package_manager'] = false
default['mozilla_firefox']['uri'] = 'https://download.mozilla.org'

case node['platform_family']
when 'debian'
  default['mozilla_firefox']['packages'] = %w(libasound2 libgtk2.0-0 libdbus-glib-1-2 libxt6)
when 'rhel'
  default['mozilla_firefox']['packages'] = %w(libasound2 libgtk2.0-0 libdbus-glib-1-2 libxt6)
end
