default['pgbarman']['packages'] = %w(barman bzip2)

default['pgbarman']['server']['servers_config_dir'] = '/etc/barman.d'

default['pgbarman']['server']['global_configuration']['barman_home'] = '/var/lib/barman'
default['pgbarman']['server']['global_configuration']['barman_lock_directory'] = '/var/run/barman'
default['pgbarman']['server']['global_configuration']['barman_user'] = 'barman'
default['pgbarman']['server']['global_configuration']['log_file'] = '/var/log/barman/barman.log'
default['pgbarman']['server']['global_configuration']['compression'] = 'bzip2'
default['pgbarman']['server']['global_configuration']['reuse_backup'] = 'off'
default['pgbarman']['server']['global_configuration']['immediate_checkpoint'] = 'true'
default['pgbarman']['server']['global_configuration']['basebackup_retry_times'] = '3'
default['pgbarman']['server']['global_configuration']['basebackup_retry_sleep'] = '30'
default['pgbarman']['server']['global_configuration']['retention_policy_mode'] = 'auto'
default['pgbarman']['server']['global_configuration']['wal_retention_policy'] = 'main'
default['pgbarman']['server']['global_configuration']['configuration_files_directory'] = node['pgbarman']['server']['servers_config_dir']
