#
# Cookbook Name:: pgbarman
# Provider:: server
#
# Author:: LLC Express 42 (info@express42.com)
#
# Copyright (C) 2016 LLC Express 42
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
# of the Software, and to permit persons to whom the Software is furnished to do
# so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#

use_inline_resources

provides :pgbarman_server if defined? provides

action :create do
  user = node['pgbarman']['server']['global_configuration']['barman_user']
  additional_parameters = Mash.new(new_resource.additional_parameters)
  full_backup_time = new_resource.full_backup_time

  template "#{node['pgbarman']['server']['servers_config_dir']}/#{new_resource.name}.conf" do
    source 'server/server.conf.erb'
    owner user
    group user
    mode '0640'
    variables(
      server_name: new_resource.name,
      ssh_command: new_resource.ssh_command,
      conninfo: new_resource.pg_conninfo,
      retention_policy: new_resource.retention_policy,
      additional_configuration: additional_parameters
    )
    cookbook 'pgbarman'
  end

  cron_d "barman_backup_for_#{new_resource.name}" do
    command "barman backup #{new_resource.name}"
    user user
    minute full_backup_time[:minute]
    hour full_backup_time[:hour]
    day full_backup_time[:day]
    month full_backup_time[:month]
    weekday full_backup_time[:weekday]
  end
end
