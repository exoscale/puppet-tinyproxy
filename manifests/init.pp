# == Class tinyproxy
#
# This module manages tinyproxy
#
# === Parameters
#
# [*ensure*]
#   Optional. If service should be managed. Valid values: present, absent
#
# [*package*]
#   Optional. Name of package to install
#
# [*autoupgrade*]
#   Optional. Boolean or version to pin
#
# [*service*]
#   Optional. Name of service to manage
#
# [*user*]
#   Optional. System user to run the service
#
# [*group*]
#    Optional. System group to run the service
#
# [*port*]
#   Optional. Port to listen to
#
# [*listen*]
#   Optional. Interface to listen to
#
# [*bind*]
#   Optional. Interface to bind outgoing connections
#
# [*bindsame*]
#   Optional. Boolean if same interface should be used for outgoing as incoming
#
# [*connection_timeout*]
#   Optional. Proxy timeout in seconds
#
# [*allow*]
#   Optional. Array of clients allowed access
#
# [*errorfiles*]
#   Optional. Hash of Statuscode => /Path/To/File
#   For example { 404 => "/path/to/my/404.html", 500 => "/path/to/my/500.html" }
#
# [*defaulterrorfile*]
#   Optional. Path to default error file
#
# [*stathost*]
#   Optional. Host name or ip address of stat host
#
# [*statfile*]
#   Optional. HTML file that gets sent when a request is made for the stathost
#
# [*logfile*]
#   Optional. Path to log file
#
# [*syslog*]
#   Optional. Boolean if to use syslog
#
# [*loglevel*]
#   Optional. One of Critical, Error, Warning, Notice, Connect, Info
#
# [*pidfile*]
#   Optional. Path to pid file
#
# [*maxclients*]
#   Optional. Max amount of concurrent clients
#
# [*minspareservers*]
#   Optional. Minimum amount of server processes spawned
#
# [*maxspareservers*]
#   Optional. Maximum amount of server processes spawned
#
# [*startservers*]
#   Optional. Amount of server processes spawned on startup
#
# [*maxrequestsperchild*]
#   Optional. Number of connections to handle until the thread is killed
#
# [*viaproxyname*]
#   Optional. Host name to set in the Via header
#
# [*disableviaheader*]
#   Optional. Boolean to disable Via header
#
# [*filter*]
#   Optional. Path to filter file
#
# [*filterurls*]
#   Optional. Boolean to filter on URL rather than domain
#
# [*filterextended*]
#   Optional. Boolean to use POSIX extended regex rather than basic
#
# [*filtercasesensitive*]
#   Optional. Boolean to use case sensitive regexps
#
# [*filterdefaultdeny*]
#   Optional. Boolean to set default filtering policy
#
# [*anonymous*]
#   Optional. Array of headers allowed through anonymous proxying
#
# [*connectport*]
#   Optional. Array of allowed ports to use CONNECT
#
# [*reverseonly*]
#   Optional. Boolean if reverse proxy only should be enabled
#
# [*reversemagic*]
#   Optional. Boolean if cookie tracking of reverse proxy mappings should be used
#
# [*config_source*]
#   Optional. Path to puppet source file to use as tinyproxy configuration
#
# Requires: see Modulefile
#
# === Sample Usage
#
# class { 'tinyproxy':
#   ensure  => present,
#   port    => 8080,
# }
#
class tinyproxy ( $ensure = present,
                  $package = $tinyproxy::params::config['package'],
                  $autoupgrade = $tinyproxy::params::config['autoupgrade'],
                  $service = $tinyproxy::params::config['service'],
                  $user = $tinyproxy::params::config['user'],
                  $group = $tinyproxy::params::config['group'],
                  $port = $tinyproxy::params::config['port'],
                  $listen = $tinyproxy::params::config['listen'],
                  $bind = $tinyproxy::params::config['bind'],
                  $bindsame = $tinyproxy::params::config['bindsame'],
                  $connection_timeout = $tinyproxy::params::config['connection_timeout'],
                  $allow = $tinyproxy::params::config['allow'],
                  $errorfiles = $tinyproxy::params::config['errorfiles'],
                  $defaulterrorfile = $tinyproxy::params::config['defaulterrorfile'],
                  $stathost = $tinyproxy::params::config['stathost'],
                  $statfile = $tinyproxy::params::config['statfile'],
                  $logfile = $tinyproxy::params::config['logfile'],
                  $syslog = $tinyproxy::params::config['syslog'],
                  $log_level = $tinyproxy::params::config['log_level'],
                  $pidfile = $tinyproxy::params::config['pidfile'],
                  $maxclients = $tinyproxy::params::config['maxclients'],
                  $minspareservers = $tinyproxy::params::config['minspareservers'],
                  $maxspareservers = $tinyproxy::params::config['maxspareservers'],
                  $startservers = $tinyproxy::params::config['startservers'],
                  $maxrequestsperchild = $tinyproxy::params::config['maxrequestsperchild'],
                  $viaproxyname = $tinyproxy::params::config['viaproxyname'],
                  $disableviaheader = $tinyproxy::params::config['disableviaheader'],
                  $filter = $tinyproxy::params::config['filter'],
                  $filterurls = $tinyproxy::params::config['filterurls'],
                  $filterextended = $tinyproxy::params::config['filterextended'],
                  $filtercasesensitive = $tinyproxy::params::config['filtercasesensitive'],
                  $filterdefaultdeny = $tinyproxy::params::config['filterdefaultdeny'],
                  $anonymous = $tinyproxy::params::config['anonymous'],
                  $connectport = $tinyproxy::params::config['connectport'],
                  $reverseonly = $tinyproxy::params::config['reverseonly'],
                  $reversemagic = $tinyproxy::params::config['reversemagic'],
                  $xtinyproxy = $tinyproxy::params::config['xtinyproxy'],
                  $config_source = '' ) inherits tinyproxy::params {

  $template = $config_source ? {
    '' => template('tinyproxy/tinyproxy.conf.erb'),
    default => ''
  }
  $ensure_file = $ensure ? {
    present => file,
    default => $ensure
  }
  case $ensure {
    present: {
      $version = $autoupgrade ? {
        /^[0-9]/  => $autoupgrade,
        true      => latest,
        default   => present
      }
      service { $service:
        ensure      => running,
        enable      => true,
        hasstatus   => $tinyproxy::params::config['hasstatus'],
        hasrestart  => $tinyproxy::params::config['hasrestart'],
        require     => Package[$package],
        subscribe   => Concat[$tinyproxy::params::config['configfile']]
      }
    }
    absent: {
      $version = $ensure
    }
    default: {
      fail("Unsupported ensure parameter ${ensure}. Valid values are: present, absent")
    }
  }

  package { $package:
    ensure => $version
  }

  concat { $tinyproxy::params::config['configfile']:
    owner   => root,
    group   => root,
    mode    => '0644',
    require => Package[$package],
  }
  concat::fragment { 'tinyproxy_main':
    target  => $tinyproxy::params::config['configfile'],
    content => $template,
    source  => $config_source,
    order   => 10,
  }

}
