class benchbox{

  vcsrepo { '/home/vagrant/BenchBox':
    ensure   => present, # present
    provider => git,
    source   => 'https://github.com/RaulGracia/BenchBox.git',
    user     => 'vagrant',
    owner    => 'vagrant',
    group    => 'vagrant',
  # require  => Exec['ssh know github'] # via ssh and etc. for private repo
  }


  vcsrepo { '/home/vagrant/doFoo':
    ensure   => present, # present
    provider => git,
    source   => 'https://github.com/2XL/doFoo.git',
    user     => 'vagrant',
    owner    => 'vagrant',
    group    => 'vagrant',
  # require  => Exec['ssh know github'] # via ssh and etc. for private repo
  }->
  file # create a config file in the shared directory for this slave
  {
    ["/vagrant/slaves/conf/$hostname.conf" , "/vagrant/slaves/log/$hostname.log" ]:
      recurse => true,
      ensure  => present,
      mode    => 0777,
      content => $hostname,
  # notify  => Service['motd'] # reload the benchbox simulator when config file changes...
  }->
  file{
    '/home/vagrant/BenchBox/xl_markov_min_regular.csv':
      recurse => true,
      ensure => present,
      source=> 'puppet:///modules/benchbox/chain/xl_markov_regular_all_sid_ms.csv'
  }->
  file{
    '/home/vagrant/doFoo/profile.csv':
      recurse => true,
      ensure => present,
      content=> $hostname
  }

  host {
    'master.com':
      ip=> '192.168.0.40'
  }
/*
service {
  'count-logins':
    provider  => 'base',
    ensure    => 'running',
    binary    => '/vagrant/scripts/bootstrap',
    start     => '/vagrant/scripts/bootstrap --daemonize',
    subscribe => File['/vagrant/scripts/bootstrap'],
}
*/
/*
// VIA SSH
vcsrepo { '/path/to/repo':
ensure     => latest,
provider   => git,
source     => 'git://username@example.com/repo.git',
user       => 'toto', #uses toto's $HOME/.ssh setup
require    => File['/home/toto/.ssh/id_rsa'], // TODO
}
*/
/*
install mongodb
install nodejs
*/


/*

*/
}
