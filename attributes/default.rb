default['meetbot']['user']            = 'vagrant'
default['meetbot']['directory']       = "/home/#{node['meetbot']['user']}/ircbot"

default['meetbot']["Supybot_version"] = 'Supybot-0.83.4.1'
default['meetbot']['Supybot_source']  = "http://garr.dl.sourceforge.net/project/supybot/supybot/#{node['meetbot']['Supybot_version']}/#{node['meetbot']['Supybot_version']}.zip"

default['meetbot']['logUrlPrefix'] = 'http://myawesomedomain.com/meetbot'
default['meetbot']['MeetBotInfoURL'] = 'https://wiki.debian.org/MeetBot'
