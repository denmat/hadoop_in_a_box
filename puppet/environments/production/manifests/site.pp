# IMPORTS:
# import all other node definitions from nodes.pp.
import 'nodes.pp'

# location of the filebucket 
filebucket { main: server => puppet }

# common path used by puppet when looking to execute things (can be overriden in modules if required).
Exec {
    path        => '/sbin:/usr/sbin:/usr/local/sbin:/bin:/usr/bin:/usr/local/bin'
}
    
# Tells us to igore all '.svn' files.
File {
    ignore      => [ '.svn','.git' ],
    owner       => root,
    group       => root,
}

 # declare stages
  stage { repos: before => Stage[first] }
  stage { first: before => Stage[main] }
  stage { last: require => Stage[main] }

