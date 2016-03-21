require 'chefspec'
require 'chefspec/berkshelf'
require_relative '../libraries/default'

VER = '38.5.0esr'

at_exit { ChefSpec::Coverage.report! }
