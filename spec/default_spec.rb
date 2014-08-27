require 'spec_helper'

describe 'meetbot::default' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }
  
  it 'downloads the Supybot' do
    expect(chef_run).to create_remote_file('/Users/jasghar/.chef/cache/Supybot-0.83.4.1.zip')
  end

  it 'downloads the Meetbot' do
    expect(chef_run).to create_remote_file('/Users/jasghar/.chef/cache/MeetBot-current.tar.gz')
  end

  it 'runs the prep script' do
    expect(chef_run).to run_script('prep')
  end

  it 'creates the directory for ircbot' do
    expect(chef_run).to create_directory('/home/vagrant/ircbot')
  end

  it 'creates the virtual_env for ircbot' do
    skip 'not sure how to test virtual_env yet'
  end

  it 'runs the setup script' do
    expect(chef_run).to run_script('setup meetbot')
  end

  it 'creates the template' do
    expect(chef_run).to create_template('/home/vagrant/run_me.sh')
  end
end
