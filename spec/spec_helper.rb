require 'chefspec'
require 'chefspec/berkshelf'
require_relative '../libraries/default'

VER = '42.0'

at_exit { ChefSpec::Coverage.report! }
