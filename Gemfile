source 'https://rubygems.org'

gem 'chef', '~> 12.6'

group :lint do
  gem 'cookstyle'
  gem 'foodcritic'
end

group :unit do
  gem 'berkshelf'
  gem 'chefspec'
end

group :integration do
  gem 'kitchen-dokken'
  gem 'kitchen-localhost'
  gem 'kitchen-vagrant'
  gem 'test-kitchen'
  gem 'winrm-fs'
end
