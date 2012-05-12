# package a vagrant box

namespace :vagrant_build do
  desc 'build the vagrant box'
  task :build_box, :vm_name, :box_name do |t, args|
    %x(vagrant package --base args{:vm_name] --output args[:box_name] --vagrantfile Vagrantfile 
  end
end
