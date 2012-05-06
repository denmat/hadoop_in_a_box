namespace :vagrant_setup do
  pub_key = 'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key'
  desc 'set hostname to vagrant-centos-6.vagrantup.com'
  task :set_hostname do
    %x(sed -i 's/HOSTNAME.*/HOSTNAME=vagrant-centos-6.vagrantup.com/' /etc/sysconfig/network)
  end

  desc 'create vagrant user'
  task :add_user => [:add_admin_group] do
    %x(useradd -u 1001 -m vagrant -G admin --password \
         '$6$vN.3dvly$Lqoljs7/RwdzhLUYRH1U3NfA5fbZUTn0PX701Ql3nJYSQ5Q1V8wRoS4S4uXmFfmDELlCc6wlL0zHBtiI5H/e4/')
    Dir.mkdir('/home/vagrant/.ssh', 0700)
    File.chown(1001,1001, '/home/vagrant/.ssh')
    File.chmod(0700, '/home/vagrant/.ssh')
    f = File.open('/home/vagrant/.ssh/authorized_keys', 'w')
    puts f << pub_key
  end

  desc 'add admin group'
  task :add_admin_group do
    %x(groupadd -g 500 admin)
  end

  desc 'set sudoers'
  task :set_sudoers do
    %x(printf '%%admin ALL=NOPASSWD: ALL\nDefaults    env_keep += \"SSH_AUTH_SOCKS\"\n' > /etc/sudoers.d/vagrant)
    %x(sed -i 's/Defaults[[:space:]]*requiretty/Defaults    \!requiretty/' /etc/sudoers)
    File.chmod(0440, '/etc/sudoers.d/vagrant')
  end

  desc 'tweak sshd - remove UseDNS'
  task :tweak_sshd do
    %x(sed -i 's/#UseDNS[[:space:]]* yes/UseDNS no/' /etc/ssh/sshd_config)
    %x(/sbin/service sshd reload)
  end

  desc 'complete all vagrant setup tasks'
  task :run => [ :set_hostname, :add_admin_group, :add_user, :set_sudoers, :tweak_sshd ]
end
