# vim: ts=2:sts=2:sw=2:expandtab

class aws-postgresql::disks {

  $general_packages = [ 'lvm2', 'mdadm' ]

  package {$general_packages: ensure => latest, before => Exec['create_disk_mirror'] }

  $db_disk_list = hiera('postgresql_disk_list')

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
    require => [Exec['create_disk_mirror'],Exec['create_db_pv']],
  }

  exec {"create_db_lvm_system":
    command => "/sbin/lvcreate -L 2G -n lv_db_system vg_data",
    onlyif  => "/usr/bin/test `lvscan |grep -c 'lv_db_system'` -eq 0",
    require => [Exec['create_disk_mirror'],Exec['create_db_pv'],Exec["create_db_vg"]],
  }
  exec {"create_db_lvm_log":
    command => "/sbin/lvcreate -L 2G -n lv_db_log vg_data",
    onlyif  => "/usr/bin/test `lvscan |grep -c 'lv_db_log'` -eq 0",
    require => [Exec['create_disk_mirror'],Exec['create_db_pv'],Exec["create_db_vg"]],
  }
  exec {"create_db_lvm_xlog":
    command => "/sbin/lvcreate -L 2G -n lv_db_xlog vg_data",
    onlyif  => "/usr/bin/test `lvscan |grep -c 'lv_db_system'` -eq 0",
    require => [Exec['create_disk_mirror'],Exec['create_db_pv'],Exec["create_db_vg"]],
  }
  exec {"create_db_lvm_vol1":
    command => "/sbin/lvcreate -L 2G -n lv_db_vol1 vg_data",
    onlyif  => "/usr/bin/test `lvscan |grep -c 'lv_db_vol1'` -eq 0",
    require => [Exec['create_disk_mirror'],Exec['create_db_pv'],Exec["create_db_vg"]],
  }

  exec {"mkfs_db_system":
    command => "/sbin/mkfs.ext4 -m 0 /dev/vg_data/lv_db_system && touch /root/.diskdonedbsystem",
    creates => "/root/.diskdonedbsystem",
    require => [Exec["create_db_lvm_system"],Exec["create_db_lvm_log"],Exec["create_db_lvm_xlog"],Exec["create_db_lvm_vol1"]],
  }
  exec {"mkfs_db_vol1":
    command => "/sbin/mkfs.ext4 -m 0 /dev/vg_data/lv_db_vol1 && touch /root/.diskdonedbvol1",
    creates => "/root/.diskdonedbvol1",
    require => [Exec["create_db_lvm_system"],Exec["create_db_lvm_log"],Exec["create_db_lvm_xlog"],Exec["create_db_lvm_vol1"]],
  }
  exec {"mkfs_db_xlog":
    command => "/sbin/mkfs.ext2 -m 0 /dev/vg_data/lv_db_xlog && touch /root/.diskdonedbxlog",
    creates => "/root/.diskdonedbxlog",
    require => [Exec["create_db_lvm_system"],Exec["create_db_lvm_log"],Exec["create_db_lvm_xlog"],Exec["create_db_lvm_vol1"]],
  }
  exec {"mkfs_db_log":
    command => "/sbin/mkfs.ext2 -m 0 /dev/vg_data/lv_db_log && touch /root/.diskdonedblog",
    creates => "/root/.diskdonedblog",
    require => [Exec["create_db_lvm_system"],Exec["create_db_lvm_log"],Exec["create_db_lvm_xlog"],Exec["create_db_lvm_vol1"]],
  }

  file {["/srv","/srv/pgsql","/srv/pgsql/9.1","/srv/pgsql/9.1/system","/srv/pgsql/9.1/xlog","/srv/pgsql/9.1/log","/srv/pgsql/9.1/vol1"]:
    ensure => directory
  }

  mount { "/srv/pgsql/9.1/system":
    ensure  => mounted,
    device  => "/dev/vg_data/lv_db_system",
    fstype  => "ext4",
    options => "nobarrier,noatime,defaults",
    require => [Exec['mkfs_db_log'],
                Exec['mkfs_db_xlog'],
                Exec['mkfs_db_vol1'],
                Exec['mkfs_db_system'],
                File['/srv/pgsql/9.1/system']],
  }
  mount { "/srv/pgsql/9.1/xlog":
    ensure  => mounted,
    device  => "/dev/vg_data/lv_db_xlog",
    fstype  => "ext2",
    options => "defaults",
    require => [Exec['mkfs_db_log'],
                Exec['mkfs_db_xlog'],
                Exec['mkfs_db_vol1'],
                Exec['mkfs_db_system'],
                File['/srv/pgsql/9.1/xlog']],
  }
  mount { "/srv/pgsql/9.1/log":
    ensure  => mounted,
    device  => "/dev/vg_data/lv_db_log",
    fstype  => "ext2",
    options => "defaults",
    require => [Exec['mkfs_db_log'],
                Exec['mkfs_db_xlog'],
                Exec['mkfs_db_vol1'],
                Exec['mkfs_db_system'],
                File['/srv/pgsql/9.1/log']],
  }
  mount { "/srv/pgsql/9.1/vol1":
    ensure  => mounted,
    device  => "/dev/vg_data/lv_db_vol1",
    fstype  => "ext4",
    options => "nobarrier,noatime,defaults",
    require => [Exec['mkfs_db_log'],
                Exec['mkfs_db_xlog'],
                Exec['mkfs_db_vol1'],
                Exec['mkfs_db_system'],
                File['/srv/pgsql/9.1/vol1']],
  }
}
