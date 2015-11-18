name 'mozilla_firefox'
maintainer 'Dennis Hoer'
maintainer_email 'dennis.hoer@gmail.com'
license 'MIT'
description 'Installs Mozilla Firefox browser'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.0.0'

%w(redhat centos windows mac_os_x debian ubuntu).each do |os|
  supports os
end

depends 'dmg', '~> 2.2'
depends 'windows', '~> 1.0'

source_url 'https://github.com/dhoer/mozilla_firefox' if respond_to?(:source_url)
issues_url 'https://github.com/dhoer/mozilla_firefox/issues' if respond_to?(:issues_url)
