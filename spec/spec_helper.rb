require 'chefspec'
require 'chefspec/berkshelf'
require_relative '../libraries/default'

VER = '45.7.0esr'.freeze

at_exit { ChefSpec::Coverage.report! }
