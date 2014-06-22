require 'chefspec'
require_relative 'spec_helper'

describe 'twemproxy::default' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'includes the apt recipe' do
    expect(chef_run).to include_recipe('apt')
  end

  it 'installs redis-server package' do
    expect(chef_run).to install_package('redis-server')
  end

  it 'enables and starts the redis-server service' do
    expect(chef_run).to enable_service('redis-server')
    expect(chef_run).to restart_service('redis-server')
  end

  it 'enables and starts the redis-server2 service' do
    expect(chef_run).to enable_service('redis-server2')
    expect(chef_run).to start_service('redis-server2')
  end

  it 'creates the /etc/nutcracker directory' do
    expect(chef_run).to create_directory('/etc/nutcracker')
  end

  it 'creates the /var/run/nutcracker directory' do
    expect(chef_run).to create_directory('/var/run/nutcracker').with(
      owner: 'redis',
      group: 'redis'
    )
  end

  it 'creates the /etc/nutcracker/nutcracker.conf' do
    expect(chef_run).to create_template('/etc/nutcracker/nutcracker.conf')
  end

  it 'creates the /etc/init.d/nutcracker' do
    expect(chef_run).to create_template('/etc/init.d/nutcracker')
  end

  it 'enables and starts the nutcracker service' do
    expect(chef_run).to enable_service('nutcracker')
    expect(chef_run).to start_service('nutcracker')
  end
end
