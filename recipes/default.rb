#
# Cookbook Name:: meetbot-cookbook
# Recipe:: default
#
# Copyright (C) 2014 
#
# 
#

include_recipe "python"

# Pull down Supybot
remote_file "#{Chef::Config[:file_cache_path]}/#{node['meetbot']['Supybot_version']}.zip" do
  source "#{node['meetbot']['Supybot_source']}"
end

# Pull down Meetbot plugin
remote_file "#{Chef::Config[:file_cache_path]}/MeetBot-current.tar.gz" do
  source "http://code.zgib.net/MeetBot/MeetBot-current.tar.gz"
end

case node["platform_family"]
when "debian"
  %w{python-virtualenv unzip}.each do |pkg|
    package pkg do
      action [:install]
    end
  end

when "rhel"
  %w{unzip}.each do |pkg|
    package pkg do
      action [:install]
    end
  end

end


script "prep" do
  interpreter "bash"
  user "root"
  cwd "#{Chef::Config[:file_cache_path]}"
  creates "#{Chef::Config[:file_cache_path]}/#{node['meetbot']['Supybot_version']}"
  code <<-EOH
    STATUS=0
    unzip #{node['meetbot']['Supybot_version']}.zip || STATUS=1
    tar xvzf MeetBot-current.tar.gz || STATUS=1
    mv MeetBot-current/ircmeeting MeetBot-current/MeetBot/ || STATUS=1
    exit $STATUS
    EOH
end

directory "#{node['meetbot']['directory']}" do
  action :create
end

python_virtualenv "#{node['meetbot']['directory']}" do
  action :create
  owner "#{node['meetbot']['user']}"
  group "#{node['meetbot']['user']}"
end

case node["platform_family"]
when "debian"
  meetbot_supybot_version = "#{node['meetbot']['Supybot_version']}" 
  meetbot_directory = "#{node['meetbot']['directory']}"
  meetbot_user = "#{node['meetbot']['user']}"

  script "setup meetbot" do
    interpreter "bash"
    user "root"
    cwd "#{node['meetbot']['directory']}"
    code <<-EOH
    STATUS=0
    source bin/activate || STATUS=1
    cd "#{Chef::Config[:file_cache_path]}"/"#{meetbot_supybot_version}" || STATUS=1
    python setup.py install || STATUS=1
    mv "#{Chef::Config[:file_cache_path]}/MeetBot-current/MeetBot/" "#{meetbot_directory}/lib/python2.7/site-packages/supybot/plugins/" || STATUS=1
    chown -R "#{meetbot_user}"."#{meetbot_user}" "#{meetbot_directory}" || STATUS=1
    exit $STATUS
    EOH
  end

when "rhel"
  meetbot_supybot_version = "#{node['meetbot']['Supybot_version']}" 
  meetbot_directory = "#{node['meetbot']['directory']}"
  meetbot_user = "#{node['meetbot']['user']}"

  script "setup meetbot" do
    interpreter "bash"
    user "root"
    cwd "#{node['meetbot']['directory']}"
    code <<-EOH
    STATUS=0
    source bin/activate || STATUS=1
    cd "#{Chef::Config[:file_cache_path]}"/"#{meetbot_supybot_version}" || STATUS=1
    python setup.py install || STATUS=1
    mv "#{Chef::Config[:file_cache_path]}/MeetBot-current/MeetBot/" "#{meetbot_directory}/lib/python2.6/site-packages/supybot/plugins/" || STATUS=1
    chown -R "#{meetbot_user}"."#{meetbot_user}" "#{meetbot_directory}" || STATUS=1
    exit $STATUS
    EOH
  end

end

template "/home/#{node['meetbot']['user']}/run_me.sh" do
  source "run_me.sh.erb"
  owner "#{node['meetbot']['user']}"
  group "#{node['meetbot']['user']}"
  mode "0755"
end

case node["platform_family"]
when "debian"
  template "#{meetbot_directory}/lib/python2.7/site-packages/supybot/plugins/MeetBot/ircmeeting/meetingLocalConfig.py" do
    source "meetingLocalConfig.py.erb"
    owner "#{node['meetbot']['user']}"
    group "#{node['meetbot']['user']}"
    mode "0755"
  end

when "rhel"
# TODO
end



