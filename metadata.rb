name 'mozilla_firefox'
maintainer 'Dennis Hoer'
maintainer_email 'dennis.hoer@gmail.com'
license 'MIT'
description 'Installs Mozilla Firefox browser'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url 'https://github.com/dhoer/chef-mozilla_firefox'
issues_url 'https://github.com/dhoer/chef-mozilla_firefox/issues'
version '3.0.1'

chef_version '>= 12.6'

%w(redhat centos windows mac_os_x debian ubuntu).each do |os|
  supports os
end

depends 'dmg', '>= 3.0'
