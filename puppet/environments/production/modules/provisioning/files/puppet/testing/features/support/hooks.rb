require 'active_record'
require 'database_cleaner'
require 'tmpdir'

  DatabaseCleaner.strategy = :truncation
  # puppet will want to create some directories with storeconfigs
  @@vardir = Dir.mktmpdir

Before do
  # adjust local configuration like this
  # @puppetcfg['confdir']  = File.join(File.dirname(__FILE__), '..', '..')
  @puppetcfg['manifest'] = File.join(@puppetcfg['confdir'], 'environments/production/manifests', 'site.pp')
  @puppetcfg['modulepath']  = "/etc/puppet/environments/production/modules:/etc/puppet/environments/common-modules"

  # for storeconfigs
  @puppetcfg['vardir'] = @@vardir
  @puppetcfg['storeconfigs'] = true
  @puppetcfg['thin_storeconfigs'] = true
  @puppetcfg['dblocation'] = ':memory:'


  # adjust facts like this
  # @facts['']
  # @facts['architecture'] = "i386"
end
