# A class to distribute Kerberos keytabs in a sane manner
#
# Users should feel free to do what they like, but this will be consistent
#
# @param keytab_source
# @author Trevor Vaughan <tvaughan@onyxpoint.com>
#
class krb5::keytab (
  $keytab_source = "puppet:///modules/krb5_files/keytabs/${facts['fqdn']}"
){

  file { '/etc/krb5_keytabs':
    ensure  => 'directory',
    owner   => 'root',
    group   => 'root',
    mode    => '0400',
    tag     => 'firstrun',
    source  => $keytab_source,
    recurse => true
  }

  file { '/etc/krb5.keytab':
    ensure  => 'file',
    source  => 'file:///etc/krb5_keytabs/krb5.keytab',
    require => File['/etc/krb5_keytabs']
  }
}
