# Base lwrp execution
test_server = 'localhost'

include_recipe 'pgbarman'
pgbarman_server 'base_test' do
  ssh_command "ssh postgres@#{test_server}"
  pg_conninfo "host=#{test_server} user=postgres"
  retention_policy 'RECOVERY WINDOW OF 7 Days'
end

# with additional params
pgbarman_server 'base_test_with_params' do
  ssh_command "ssh postgres@#{test_server}"
  pg_conninfo "host=#{test_server} user=postgres"
  retention_policy 'RECOVERY WINDOW OF 12 MONTHS'
  additional_parameters(
    network_compression: 'True',
    pre_backup_script:   '/bin/true'
  )
end
