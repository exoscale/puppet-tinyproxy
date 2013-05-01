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
      $configfile = hiera('tinyproxy-configfile', '/etc/tinyproxy.conf')
      $package = hiera('tinyproxy-package', 'tinyproxy')
      $service = hiera('tinyproxy-service', 'tinyproxy')
      $hasstatus = hiera('tinyproxy-hasstatus', false)
      $hasrestart = hiera('tinyproxy-harestart', true)
      $user = hiera('tinyproxy-user', 'nobody')
      $group = hiera('tinyproxy-group', 'nogroup')
      $port = hiera('tinyproxy-port', '3128')
      $listen = hiera('tinyproxy-listen', undef)
      $bind = hiera('tinyproxy-bind', undef)
      $bindsame = hiera('tinyproxy-bindsame', undef)
      $connection_timeout = hiera('tinyproxy-connection-timeout', '600')
      $allow = hiera('tinyproxy-allow', [])
      $errorfiles = hiera('tinyproxy-errorfiles', {})
      $defaulterrorfile= hiera('tinyproxy-defaulterrorfile', '/usr/share/tinyproxy/default.html')
      $stathost = hiera('tinyproxy-stathost', undef)
      $statfile = hiera('tinyproxy-statfile', '/usr/share/tinyproxy/stats.html')
      $logfile = hiera('tinyproxy-logfile', '/var/log/tinyproxy/tinyproxy.log')
      $syslog = hiera('tinyproxy-syslog', undef)
      $log_level = hiera('tinyproxy-loglevel', 'Info')
      $pidfile = hiera('tinyproxy-pidfile', '/var/run/tinyproxy/tinyproxy.pid')
      $xtinyproxy = hiera('tinyproxy-xtinyproxy', undef)
      $maxclients = hiera('tinyproxy-maxclients', '100')
      $minspareservers = hiera('tinyproxy-minspareservers', '5')
      $maxspareservers = hiera('tinyproxy-maxspareservers', '20')
      $startservers = hiera('tinyproxy-startservers', '10')
      $maxrequestsperchild = hiera('tinyproxy-maxrequestsperchild', '0')
      $viaproxyname = hiera('tinyproxy-viaproxyname', 'tinyproxy')
      $disableviaheader = hiera('tinyproxy-disableviaheader', undef)
      $filter = hiera('tinyproxy-filter', undef)
      $filterurls = hiera('tinyproxy-filterurls', undef)
      $filterextended = hiera('tinyproxy-filterextended', undef)
      $filtercasesensitive = hiera('tinyproxy-filtercasesensitive', undef)
      $filterdefaultdeny = hiera('tinyproxy-filterdefaultdeny', undef)
      $anonymous = hiera('tinyproxy-anonymous', [])
      $connectport = hiera('tinyproxy-connectport', [])
      $reverseonly = hiera('tinyproxy-reverseonly', undef)
      $reversemagic = hiera('tinyproxy-reversemagic', undef)
      $reversebaseurl = hiera('tinyproxy-reversebaseurl', undef)
    }
    default: {
      fail("Unsupported distro ${::lsbdistcodename}")
    }
  }
}
