name 'pgbarman'
maintainer 'Express 42'
maintainer_email 'cookbooks@express42.com'
license 'MIT'
issues_url 'https://github.com/express42-cookbooks/pgbarman/issues' if respond_to?(:issues_url)
source_url 'https://github.com/express42-cookbooks/pgbarman' if respond_to?(:source_url)
description 'Installs/Configures pgbarman'
long_description 'Installs/Configures pgbarman'
version '1.0.0'
chef_version '>= 12'

depends 'cron'

supports 'ubuntu'
supports 'debian'
