require 'chefspec'
require 'chefspec/berkshelf'
require_relative '../libraries/default'

VER = '52.1.2esr'.freeze

at_exit { ChefSpec::Coverage.report! }
