require 'spec_helper'

describe 'mozilla_firefox' do
  context 'windows override default version and lang' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'windows', version: '2008R2') do |node|
        node.set['mozilla_firefox']['version'] = '42.0'
        node.set['mozilla_firefox']['lang'] = 'fr'
      end.converge(described_recipe)
    end

    it 'installs 64bit french version' do
      expect(chef_run).to install_windows_package('Mozilla Firefox 42.0 (x64 fr)').with(
        source:
          'https://download-installer.cdn.mozilla.net/pub/firefox/releases/42.0/win64/fr/Firefox%20Setup%2042.0.exe',
        installer_type: :custom,
        options: '-ms'
      )
    end
  end

  context 'windows install 64bit esr' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'windows', version: '2008R2').converge(described_recipe)
    end

    it 'installs 32bit version' do
      expect(chef_run).to install_windows_package("Mozilla Firefox #{VER.gsub('esr', '')} ESR (x64 en-US)").with(
        source: "https://download-installer.cdn.mozilla.net/pub/firefox/releases/#{VER}/win64/en-US/"\
        "Firefox%20Setup%20#{VER}.exe",
        installer_type: :custom,
        options: '-ms'
      )
    end
  end

  context 'windows install 32bit esr' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'windows', version: '2008R2') do |node|
        node.set['mozilla_firefox']['32bit_only'] = true
      end.converge(described_recipe)
    end

    it 'installs 32bit version' do
      expect(chef_run).to install_windows_package("Mozilla Firefox #{VER.gsub('esr', '')} ESR (x86 en-US)").with(
        source: "https://download-installer.cdn.mozilla.net/pub/firefox/releases/#{VER}/win32/en-US/"\
        "Firefox%20Setup%20#{VER}.exe",
        installer_type: :custom,
        options: '-ms'
      )
    end
  end

  context 'mac install of latest version' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'mac_os_x', version: '10.7.4').converge(described_recipe)
    end

    it 'installs latest version' do
      expect(chef_run).to install_dmg_package('Firefox').with(
        source: "https://download-installer.cdn.mozilla.net/pub/firefox/releases/#{VER}/mac/en-US/Firefox%20#{VER}.dmg",
        dmg_name: 'firefox'
      )
    end
  end

  context 'linux install of latest version using package manager' do
    let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

    it 'installs latest version' do
      expect(chef_run).to upgrade_package('firefox').with(
        version: nil
      )
    end
  end
end
