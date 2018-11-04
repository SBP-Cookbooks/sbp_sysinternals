name              'sbp_sysinternals'
maintainer        'Stefan Wessels Beljaars'
maintainer_email  'swesselsbeljaars@schubergphils.com'
license           'Apache-2.0'
description       'Installs/Configures Sysinternals and BGInfo'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           '1.0.0'
chef_version      '>= 14'

source_url        'https://github.com/schubergphilis/sbp_sysinternals'
issues_url        'https://github.com/schubergphilis/sbp_sysinternals/issues'

supports          'windows'

depends           'libarchive'
