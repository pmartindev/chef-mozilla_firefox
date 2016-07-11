source 'https://rubygems.org'

group :lint do
  gem 'foodcritic'
  gem 'rubocop', '~> 0.0'
  gem 'winrm-fs', '~> 0.0'
end

group :unit do
  gem 'berkshelf',  '~> 4.0' # pin to 3.1.5 due to performance issues when testing osx
  gem 'chefspec',   '~> 4.0'
end

group :integration do
  gem 'test-kitchen', '~> 1.0'
  gem 'kitchen-vagrant', '~> 0.0'
  gem 'winrm-transport', '~> 1.0'
  gem 'kitchen-dokken', '~> 0.0'
  gem 'kitchen-localhost', '~> 0.0'
end
