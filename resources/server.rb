#
# Cookbook Name:: pgbarman
# Resource:: server
#
# Author:: Express 42 (input@express42.com)
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

provides :pgbarman_server
resource_name :pgbarman_server

actions :create
default_action :create

attribute :name, kind_of: String, required: true
attribute :ssh_command, kind_of: String, required: true
attribute :pg_conninfo, kind_of: String, required: true
attribute :retention_policy, kind_of: String, required: true
attribute :additional_parameters, kind_of: Hash, default: {}
attribute :full_backup_time, kind_of: Hash, default: { minute: '0', hour: '1', day: '*', month: '*', weekday: '*' }
