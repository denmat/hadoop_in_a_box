namespace :Vbox do
  desc 'install dependencies'
  task :install_deps do
    %x(yum install -y kernel-devel gcc make)
  end

  desc 'install VboxGuestAdditions'
  task :install_vbox => [ :install_deps ] do
    %x(mount /dev/dvd /mnt)
    %x(/mnt/VBoxLinuxAdditions.run)
    %x(umount /mnt)
  end

  desc 'run vboxguests tasks'
  task :run => [ :install_deps, :install_vbox ]
end
