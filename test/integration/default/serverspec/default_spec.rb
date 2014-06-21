require 'spec_helper'

describe group('redis') do
  it { should exist }
end

describe user('redis') do
  it { should exist }
  it { should belong_to_group 'redis'}
  it { should have_login_shell '/bin/false'}
end

describe service('redis-server') do
  it { should be_enabled }
  it { should be_running }
end

describe service('redis-server2') do
  it { should be_enabled }
  it { should be_running }
end

describe service('nutcracker') do
  it { should be_enabled }
  it { should be_running }
end


describe port(6379) do
  it { should be_listening.with('tcp') }
end

describe port(6380) do
  it { should be_listening.with('tcp') }
end

describe port(23559) do
  it { should be_listening.with('tcp') }
end



