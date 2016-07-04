include_recipe 'mozilla_firefox'

version = firefox_version

raise "Firefox version returned is invalid: #{version}" unless version =~ /[\d|.]*/

log 'firefox version' do
  message version
end
