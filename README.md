# meetbot-cookbook

This is the cookbook to help set up [meetbot](https://wiki.debian.org/MeetBot) quickly and repeatably.

If you run the default recipe it'll build it for you, this has been tested on Ubuntu 14.04 and Centos 6.5

There are some options you might want to change, for example:

```ruby
default['meetbot']['user']  = 'vagrant'

default['meetbot']['logUrlPrefix'] = 'http://myawesomedomain.com/meetbot'
```

This also pushes the logs into the directory of that `$USER/ircbot/$BOTNAME/`.

Also this moment you'll need to set up via something like:

```bash
$ cd ~/ircbot
$ source bin/activate
$ supybot-wizard
```

I was thinking of automating this, but you might want more than just Meetbot after setting this up.

During the wizard you'll want to do make sure you enter these options:

```bash
Now we're going to run you through plugin configuration. There's
a variety of plugins in supybot by default, but you can create
and add your own, of course. We'll allow you to take a look at
the known plugins' descriptions and configure them if you like
what you see.

 Would you like to look at plugins individually? [y/n] y

Next comes your opportunity to learn more about the plugins that
are available and select some (or all!) of them to run in your
bot. Before you have to make a decision, of course, you'll be
able to see a short description of the plugin and, if you choose,
an example session with the plugin. Let's begin.

 What plugin would you like to look at? [Alias/Anonymous/
AutoMode/BadWords/ChannelLogger/ChannelStats/Ctcp/Dict/Dunno/
Factoids/Filter/Format/Games/Google/Herald/Internet/Karma/
Lart/Later/Limiter/Math/MeetBot/MoobotFactoids/Network/News/
NickCapture/Nickometer/Note/Plugin/Praise/Protector/Quote/
QuoteGrabs/RSS/Relay/Reply/Scheduler/Seen/Services/ShrinkUrl/
Status/String/Success/Time/Todo/Topic/URL/Unix/Utilities/
Web] MeetBot


Add a description of the plugin (to be presented to the user inside the wizard)
here.  This should describe *what* the plugin does.


 Would you like to load this plugin? [y/n] (default: y) y

Beginning configuration for MeetBot...


Done!

 Would you like add another plugin? [y/n] y

 What plugin would you like to look at? [Alias/Anonymous/
AutoMode/BadWords/ChannelLogger/ChannelStats/Ctcp/Dict/Dunno/
Factoids/Filter/Format/Games/Google/Herald/Internet/Karma/
Lart/Later/Limiter/Math/MoobotFactoids/Network/News/
NickCapture/Nickometer/Note/Plugin/Praise/Protector/Quote/
QuoteGrabs/RSS/Relay/Reply/Scheduler/Seen/Services/ShrinkUrl/
Status/String/Success/Time/Todo/Topic/URL/Unix/Utilities/
Web] ChannelLogger


Logs each channel to its own individual logfile.


 Would you like to load this plugin? [y/n] (default: y) y

Beginning configuration for ChannelLogger...


Done!
```

This will make sure that you have meetbot and channellogger running.

After the setup you'll have a `name_of_bot.conf` and you can start it via:

`supybot name_of_bot.conf`


## TODO

- Automate starting (runit?)
- Automate/Sane defaults for `name_of_bot.conf`?
- Add webserver and web user for `~/ircbot/name_of_bot/` so you can post your logs

