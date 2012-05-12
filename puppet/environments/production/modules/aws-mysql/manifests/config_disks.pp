class aws-mysql::config_disks {

  $general_packages = [ 'lvm2', 'mdadm' ]

  package {$general_packages: ensure => latest, before => Exec['create_disk_mirror'] }

  $db_disk_list = hiera('db_disk_list')

  exec {"create_disk_mirror": 
    command => "/sbin/mdadm --create /dev/md0 --chunk 512 --level 1 --raid-devices 2 --force -R $db_disk_list",
    creates => "/dev/md0",
  }

  exec {"create_db_pv":
    command => "/sbin/pvcreate /dev/md0",
    onlyif  => "/usr/bin/test `pvscan |grep -c '/dev/md0'` -eq 0",
    require => Exec['create_disk_mirror'],
  }

  exec {"create_db_vg":
    command => "/sbin/vgcreate vg_data /dev/md0",
    onlyif  => "/usr/bin/test `vgscan |grep -c 'vg_data'` -eq 0",
    require => Exec['create_db_pv'],
  }

  exec {"create_db_lvm_data":
    command => "/sbin/lvcreate -L 8G -n lv_db_data vg_data",
    onlyif  => "/usr/bin/test `lvscan |grep -c 'lv_db_data'` -eq 0",
    require => [Exec['create_db_pv'],Exec["create_db_vg"]],
  }

 exec {"create_db_lvm_log":
    command => "/sbin/lvcreate -L 1G -n lv_db_log vg_data",
    onlyif  => "/usr/bin/test `lvscan |grep -c 'lv_db_log'` -eq 0",
    require => [Exec['create_db_pv'],Exec["create_db_vg"]],
  }

  exec {"mkfs_db_data":
    command => "/sbin/mkfs.ext4 -m 0 /dev/vg_data/lv_db_data && touch /root/.diskdonedbdata",
    creates => "/root/.diskdonedbdata",
    require => [Exec["create_db_lvm_log"],Exec["create_db_lvm_data"]],
  }

  exec {"mkfs_db_log":
    command => "/sbin/mkfs.ext4 -m 0 /dev/vg_data/lv_db_log && touch /root/.diskdonedblog",
    creates => "/root/.diskdonedblog",
    require => [Exec["create_db_lvm_log"],Exec["create_db_lvm_data"]]
  } 

  file {["/data","/data/db","/data/log"]:
    ensure => directory
  }

  mount { "/data/db":
    ensure  => mounted,
    device  => "/dev/vg_data/lv_db_data",
    fstype  => "ext4",
    options => "nobarrier,noatime,defaults",
    require => File['/data/db'],
  }
  mount { "/data/log":
    ensure  => mounted,
    device  => "/dev/vg_data/lv_db_log",
    fstype  => "ext4",
    options => "nobarrier,noatime,defaults",
    require => File['/data/log'],
  }

}
