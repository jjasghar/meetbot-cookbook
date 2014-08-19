#
# Cookbook Name:: meetbot-cookbook
# Recipe:: default
#
# Copyright (C) 2014 
#
# 
#

# Pull down Supybot
remote_file "#{Chef::Config[:file_cache_path]}/Supybot-0.83.4.1.zip" do
  source "http://garr.dl.sourceforge.net/project/supybot/supybot/Supybot-0.83.4.1/Supybot-0.83.4.1.zip"
end

# Pull down Meetbot plugin
remote_file "#{Chef::Config[:file_cache_path]}/MeetBot-current.tar.gz" do
  source "http://code.zgib.net/MeetBot/MeetBot-current.tar.gz"
end

package "python-virtualenv" do
  action :install
end

package "unzip" do
  action :install
end

script "prep" do
  interpreter "bash"
  user "root"
  cwd "#{Chef::Config[:file_cache_path]}"
  creates "maybe"
  code <<-EOH
    STATUS=0
    unzip Supybot-0.83.4.1.zip || status=1
    tar xvzf MeetBot-current.tar.gz
    mv MeetBot-current/ircmeeting MeetBot-current/MeetBot/
    exit $STATUS
    EOH
end

directory "/home/vagrant/ircbot" do
  action :create
end

python_virtualenv "/home/vagrant/ircbot" do
  action :create
end

script "run the installer" do
  interpreter "bash"
  user "root"
  cwd "#{Chef::Config[:file_cache_path]}/MeetBot-current"
  creates "maybe"
  code <<-EOH
    STATUS=0
    python setup.py install || STATUS=1
    exit $STATUS
    EOH
end
