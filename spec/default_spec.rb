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

  


end