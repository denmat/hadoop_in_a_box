Puppet::Type.type(:gluster).provide(:gluster) do
  desc "This provider builds and destroys bricks"

  commands :gluster => "gluster"

  def create
    create = [command(:gluster), "volume create"]
    opt_set = [command(:gluster), "volume set"]

    if resource[:stripe] 
      create << resource[:name] << resource[:stripe] << resource[:transport] << resource[:bricks]
    end
    if resource[:replica]
      create << resource[:name] << resource[:replica] << resource[:transport] << resource[:bricks]
    end
    if resource[:options]
      resource[:options].each do |option|
        opt,param = option.split('=')
        opt_set << resource[:name] << opt << param 
      end
    end
  end

  def destroy
    vol_del = [command(:gluster), "volume delete"]
    vol_del << resource[:name]
  end

  def exists?
#    unless (`pgrep -u root glusterd` == 1)
#      gluster "volume info" << resource[:name]
#    else
#      fail ('glusterd process must be running..')
#    end
    com = [command(:gluster), "volume info"]
    com << resource[:name]
#    res = execute(com)
    `/usr/sbin/gluster volume info test1`
#    if res.match(/^Volume \S+ does not exist/)
#    this = execute(com)
#      if com 
#       puts "got com"
#      end
#    if execute(com).match(/^Volume \S+ does not exist/)
#      puts "here5"
#      return false
#      puts "there"
#    elsif execute(com).match(/.*/)
#      return true
#    elsif execute(com).match(/Connection failed. Please check if gluster daemon is operational./) 
#      raise Puppet::Error , "glusterd process must be running.."
#    end
#      puts "here4"
  end
end
