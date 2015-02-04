name             'jdr-jamwiki'
maintainer       'JDR'
maintainer_email 'rotach@gmai.com'
license          'All rights reserved'
description      'Installs/Configures a JAMwiki Instance'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends   'jdr-base',  '= 0.1.0'
depends   'java',      '= 1.29.0'
depends   'tomcat',    '~> 0.16.2'
depends   'aws',       '~> 2.5.0'