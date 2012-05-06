namespace :cleanup do
  desc 'cleanup logs'
  task :logs do
    %x(service rsyslog stop ; rm -f /var/log/messages* ; service rsyslog start)
    %x(rm -f /var/log/*-*)
  end

  desc 'clean up yum'
  task :yum do
    %x(yum clean all)
  end

  desc 'remove kernel-devel and gcc to save space'
  task :package_clean do
    %(yum erase -y kernel-devel gcc)
  end

  desc 'run all clean up tasks'
  task :run => [ :package_clean, :logs, :yum ]
end
