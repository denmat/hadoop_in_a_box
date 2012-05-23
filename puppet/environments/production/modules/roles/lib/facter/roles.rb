require 'facter'
require 'open-uri'

# access the amazon user-data meta-data to get the information about our host.
# standard format is like the following:
# node=<hostname> puppet=<master|client> mcollective=<master|client> domain=mylocal nameserver=172.19.1.10
#   role=<provisioner|dbserver|webserver|nat|vpn_nat|bastion>
#
# (roles and user-data are not limited to that selection, just an example).
#
# We will match on those values present by the user-data and collect a bunch of  facts
# about our nodes.
#
# first grab the user-data. 

require 'timeout'

begin 
  Timeout.timeout(15) {
    begin
      user_data = open('http://169.254.169.254/latest/user-data/').read
    rescue SocketError
      raise "Can't connect  user-data!"
  }
rescue Timeout::Error
  raise "connection to  user-data timed out"
end


Facter.add("role") do
  setcode do
    role = user_data.match(/role=(\w+)/)[1]
  end
end

Facter.add("node") do
  setcode do
    node = user_data.match(/node=(\S+)/)[1]
  end
end

Facter.add("certname") do
  setcode do
    if (user_data.match(/certname=(\S+)/)[1])
     cert = user_data.match(/certname=(\S+)/)[1]
    else
     cert = 'none'
    end
#    cert = user_data.match(/certname=(\S+)/)[1]
  end
end

Facter.add("puppet") do
  setcode do
    unless user_data.match(/puppet=master/) do
      puppet = 'client'
    end
    else
      puppet = 'master'
    end
  end
end

Facter.add("mcollective") do
  setcode do
    unless user_data.match(/mcollective=master/) do
      puppet = 'client'
    end
    else
      puppet = 'master'
    end
  end
end

Facter.add("domain") do 
  setcode do 
    user_data.match(/domain=(\S+)/)[1]
  end
end

Facter.add("nameserver") do 
  setcode do
    user_data.match(/nameserver=(\S+)/)[1]
  end
end
