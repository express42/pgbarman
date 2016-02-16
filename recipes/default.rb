#
# Cookbook Name:: pgbarman
# Recipe:: default
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
user = node['pgbarman']['server']['global_configuration']['barman_user']

node['pgbarman']['packages'].each do |pkg|
  package pkg
end

# Directories for pgbarman
directory node['pgbarman']['server']['global_configuration']['barman_home'] do
  user user
  group user
end

directory node['pgbarman']['server']['servers_config_dir'] do
  owner user
  group user
end

directory node['pgbarman']['server']['global_configuration']['barman_lock_directory'] do
  user user
  group user
end

# Global config
template '/etc/barman.conf' do
  source 'server/global.conf.erb'
  variables configuration: node['pgbarman']['server']['global_configuration']
end
