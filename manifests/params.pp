# == Class tinyproxy::params
#
# Settings class
#
# === Parameters
#
# None
#
class tinyproxy::params {
  $autoupgrade = false
  case $::lsbdistcodename {
    'lucid','precise': {
      #$package = hiera('tinyproxy-package', 'tinyproxy')
      #$service = hiera('tinyproxy-service', 'tinyproxy')
      #$hasstatus = hiera('tinyproxy-hasstatus', false)
      #$hasrestart = hiera('tinyproxy-harestart', true)
      #$user = hiera('tinyproxy-user', 'nobody')
      #$group = hiera('tinyproxy-group', 'nogroup')
      #$port = hiera('tinyproxy-port', '3128')
      #$connection_timeout = hiera('tinyproxy-connection-timeout', '600')
      #$allow = hiera('tinyproxy-allow', [])
      #$errorfiles = hiera('tinyproxy-errorfiles', {})
      #$defaulterrorfile= hiera('tinyproxy-defaulterrorfile', '/usr/share/tinyproxy/default.html')
      #$statfile = hiera('tinyproxy-statfile', '/usr/share/tinyproxy/stats.html')
      #$logfile = hiera('tinyproxy-logfile', '/var/log/tinyproxy/tinyproxy.log')
      #$log_level = hiera('tinyproxy-loglevel', 'Info')
      #$pidfile = hiera('tinyproxy-pidfile', '/var/run/tinyproxy/tinyproxy.pid')
      #$maxclients = hiera('tinyproxy-maxclients', '100')
      #$minspareservers = hiera('tinyproxy-minspareservers', '5')
      #$maxspareservers = hiera('tinyproxy-maxspareservers', '20')
      #$startservers = hiera('tinyproxy-startservers', '10')
      #$maxrequestsperchild = hiera('tinyproxy-maxrequestsperchild', '0')
      #$viaproxyname = hiera('tinyproxy-viaproxyname', 'tinyproxy')
      #$anonymous = hiera('tinyproxy-anonymous', [])
      #$connectport = hiera('tinyproxy-connectport', [])
      $tinyproxy_defaults = {
        configfile => "/etc/tinyproxy.conf",
        service => "tinyproxy",
        hasstatus => false,
        hasrestart => true,
        user => "nobody",
        group => "nogroup",
        port => "3128",
        connection_timeout => "600",
        allow => [],
        errorfiles => {},
        defaulterrorfile => "/usr/share/tinyproxy/default.html",
        statfile => "/usr/share/tinyproxy/stats.html",
        logfile => "/var/log/tinyproxy/tinyproxy.log",
        log_level => "Info",
        pidfile => "/var/run/tinyproxy/tinyproxy.pid",
        maxclients => "100",
        minspareservers => "5",
        maxspareservers => "20",
        startservers => "10",
        maxrequestsperchild => "0",
        viaproxyname => "tinyproxy",
        anonymous => [],
        connectport => []
      }
    $tinyproxy_config = merge($tinyproxy_defaults, hiera_hash('tinyproxy-config', {}))
    }
    default: {
      fail("Unsupported distro ${::lsbdistcodename}")
    }
  }
}
