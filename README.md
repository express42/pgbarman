# Description

Installs/Configures pgbarman global server
Generate configurations for db servers using lwrp

# Requirements

pgbarman package, at least 1.3.3 version

## Platform:

* Ubuntu 12.04+
* Debian 6+


# Attributes

* `node['pgbarman']['packages']` -  Defaults to `"%w(barman bzip2)"`.
* `node['pgbarman']['server']['servers_config_dir']` -  Defaults to `"/etc/barman.d"`.
* `node['pgbarman']['server']['global_configuration']['barman_home']` -  Defaults to `"/var/lib/barman"`.
* `node['pgbarman']['server']['global_configuration']['barman_lock_directory']` -  Defaults to `"/var/run/barman"`.
* `node['pgbarman']['server']['global_configuration']['barman_user']` -  Defaults to `"barman"`.
* `node['pgbarman']['server']['global_configuration']['log_file']` -  Defaults to `"/var/log/barman/barman.log"`.
* `node['pgbarman']['server']['global_configuration']['compression']` -  Defaults to `"bzip2"`.
* `node['pgbarman']['server']['global_configuration']['reuse_backup']` -  Defaults to `"off"`.
* `node['pgbarman']['server']['global_configuration']['immediate_checkpoint']` -  Defaults to `"true"`.
* `node['pgbarman']['server']['global_configuration']['basebackup_retry_times']` -  Defaults to `"3"`.
* `node['pgbarman']['server']['global_configuration']['basebackup_retry_sleep']` -  Defaults to `"30"`.
* `node['pgbarman']['server']['global_configuration']['retention_policy_mode']` -  Defaults to `"auto"`.
* `node['pgbarman']['server']['global_configuration']['wal_retention_policy']` -  Defaults to `"main"`.
* `node['pgbarman']['server']['global_configuration']['configuration_files_directory']` -  Defaults to `"node['pgbarman']['server']['servers_config_dir']"`.

# Recipes

* pgbarman::default

# Resources

* [pgbarman_server](#pgbarman_server)
* [pgbarman\_bidirectional_ssh](#pgbarman\_bidirectional_ssh)

## pgbarman_server

### Actions

- create: creates pgbarman server configuration

### Attribute Parameters

- name: name of barman server
- ssh_command: ssh conenction string for db server
- pg_conninfo: postgres connection string
- retention_policy: retention
- additional_parameters: additional barman paramters, see ```man 5 barman``` for server configuration details

## pgbarman\_bidirectional_ssh

### Actions

- create: creates private key and authorized_keys configuration  for bidirect ssh connections between barman and db servers

### Attribute Parameters

- name: name of barman server
- granted_user: destination user, who receives private key for authentication and authorized_keys for connection
- ssh_folder_path: path to ssh folder
- ssh_private_key: private key to use for auth
- ssh_public_keys: array of public keys from which allow to authenticate


# Examples
```
db_server = 'db01.example.org'
pgbarman_server db_server do
  ssh_command "ssh postgres@#{db_server}"
  pg_conninfo "host=#{db_server} user=postgres"
  retention_policy 'RECOVERY WINDOW OF 14 DAYS'
  additional_parameters(
    network_compression: 'True',
    reuse_backup: 'link'
  )
end
```
lwrp examples to generate private key for barman and sets public key from db01/02 to allow bidirectional connect between servers

```
pgbarman_bidirectional_ssh 'barman' do
  granted_user 'barman'
  ssh_folder_path '/var/lib/barman/.ssh'
  ssh_private_key 'barman_private_ssh_key'
  ssh_public_keys ['public_db01_key', 'public_db02_key']
end

pgbarman_bidirectional_ssh 'db01' do
  granted_user 'barman'
  ssh_folder_path '/var/lib/barman/.ssh'
  ssh_private_key 'db01_private_ssh_key'
  ssh_public_keys ['public_barman_key']
end


pgbarman_bidirectional_ssh 'db02' do
  granted_user 'barman'
  ssh_folder_path '/var/lib/barman/.ssh'
  ssh_private_key 'db02_private_ssh_key'
  ssh_public_keys ['public_barman_key']
end

```
You can find more examples in [tests](https://github.com/express42-cookbooks/pgbarman/tree/master/templates/default/server)

# ToDo

# License and Maintainer

Author:: Express 42 (cookbooks@express42.com)

Copyright (C) 2016 LLC Express 42

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software. THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
