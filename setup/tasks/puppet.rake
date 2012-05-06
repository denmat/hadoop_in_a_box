namespace :puppet do

  desc 'install puppet'
  task :gem_install_puppet do
    %x(gem install --remote puppet facter --no-ri --no-rdoc)
  end

  desc 'install all puppet requirements'
  task :run => :gem_install_puppet
end
