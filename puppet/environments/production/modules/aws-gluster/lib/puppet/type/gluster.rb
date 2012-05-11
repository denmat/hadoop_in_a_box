Puppet::Type.newtype(:gluster) do 
  @doc = "Manage gluster volumes.                                    " +
         "  gluster {'volumename':                                   " +
         "    present   => present,                                  " +
         "    bricks    => ['hostnmae:/volume', 'hostname:/volume'], " +
         "    replica   => 2,                                        " +
         "    transport => 'tcp',                                    " +
         "    tuning    => ['option=value', 'option=value'],         " +
         "  }                                                        "

  ensurable 
#  resource[:provider] = :gluster

  newparam(:name) do
    desc "Name of gluster volume"

    isnamevar
  end

  newparam(:bricks) do 
    desc "gluster bricks to add to gluster volume"

    validate do |value|
      value.each do |v|
        unless v =~ /^\S+:\/\S+/
          raise ArgumentError , "%s is not a valid brick name" % v
        end
      end
    end
  end

  newparam(:replica) do 
    validate do |value|
      unless value =~ /\d+/
        raise ArgumentError , "%s replica must be a number" % value
      end
    end
  end

  newparam(:stripe) do
    validate do |value|
      unless value =~ /\d+/
        raise ArgumentError , "%s stripe must be a number" % value
      end
    end
  end
 
  newparam(:tranport) do
    validate do |value|
      unless value =~ /tcp|rdma/
        raise ArgumentError , "%s transport must be a either tcp or rdma" % value
      end
    end
  end

  newparam(:tuning) do 
    desc "Special tuning applied to gluster volume"
 
    validate do |value|
      value.each do |v|
        unless v =~ /^\S+=\S+/
          raise ArgumentError , "%s is not valid. Must be option=value" % v
        end
      end
    end
  end
  
end
