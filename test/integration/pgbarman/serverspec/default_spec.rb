require 'spec_helper'

# pgbarman_server
describe package('barman') do
  it { should be_installed }
end

describe file('/etc/barman.d') do
  it { should be_directory }
end

describe file('/var/lib/barman/base_test_with_params') do
  it { should be_directory }
end

describe file('/var/run/barman') do
  it { should be_directory }
end

describe command('sudo -u barman barman show-server base_test') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should contain 'retention_policy: RECOVERY WINDOW OF 7 DAYS' }
  its(:stdout) { should contain 'conninfo: host=localhost user=postgres' }
  its(:stdout) { should contain 'ssh_command: ssh postgres@localhost' }
end

describe command('sudo -u barman barman show-server base_test_with_params') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should contain 'retention_policy: RECOVERY WINDOW OF 12 MONTHS' }
  its(:stdout) { should contain 'pre_backup_script: /bin/true' }
  its(:stdout) { should contain 'network_compression: True' }
end

describe file('/etc/barman.conf') do
  it { should be_file }
  it { should contain 'barman_home = /var/lib/barman' }
  it { should contain 'barman_lock_directory = /var/run/barman' }
  it { should contain 'barman_user = barman' }
  it { should contain 'basebackup_retry_sleep = 30' }
  it { should contain 'basebackup_retry_times = 3' }
  it { should contain 'compression = bzip2' }
  it { should contain 'configuration_files_directory = /etc/barman.d' }
  it { should contain 'immediate_checkpoint = true' }
  it { should contain 'log_file = /var/log/barman/barman.log' }
  it { should contain 'retention_policy_mode = auto' }
  it { should contain 'reuse_backup = off' }
  it { should contain 'wal_retention_policy = main' }
end

describe file('/etc/cron.d/barman_backup_for_base_test') do
  it { should contain '0 1 * * * barman barman backup base_test' }
end

# pgbarman_bidirectional_ssh
describe file('/var/lib/barman/.ssh') do
  it { should be_directory }
end

describe file('/var/lib/barman/.ssh/id_rsa') do
  it { should be_file }
  it { should contain 'MIIEogIBAAKCAQEAwKDNfKddfe+sddl1s86QAujg8ApzG5p01Ffziv3l0ZJh6kVK' }
end

describe file('/var/lib/barman/.ssh/authorized_keys') do
  it { should be_file }
  it { should contain 'AAAAB3NzaC1yc2EAAAADAQABAAABAQC8bRGedn/WvTzNiYwMT' }
end
