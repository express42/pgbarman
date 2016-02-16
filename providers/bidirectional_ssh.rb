#
# Cookbook Name:: pgbarman
# Provider:: bidirectional_ssh
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

provides :pgbarman_bidirectional_ssh if defined? provides

action :create do
  user = new_resource.granted_user
  authorized_keys = new_resource.ssh_public_keys.join("\n")
  ssh_folder = new_resource.ssh_folder_path

  directory ssh_folder do
    owner user
    group user
    mode '0755'
  end

  # Generate private key
  file "#{ssh_folder}/id_rsa" do
    content new_resource.ssh_private_key
    owner user
    group user
    mode '0600'
  end

  # Generate authorized_keys
  file "#{ssh_folder}/authorized_keys" do
    content authorized_keys
    owner user
    group user
    mode '0644'
  end
end
