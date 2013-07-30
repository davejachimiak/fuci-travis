require_relative '../../spec_helper'
require_relative '../../../lib/fuci/travis'

stub_class 'Travis::Repository'
stub_class 'Travis::Pro::Repository'

describe Fuci::Travis do
  describe '.default_branch' do
    after { Fuci::Travis.instance_variable_set :@default_branch, nil }

    it 'is an accessor' do
      @branch = 'branch'
      expect(Fuci::Travis.default_branch).to_be_nil
      Fuci::Travis.default_branch = @branch
      expect(Fuci::Travis.default_branch).to_equal @branch
    end
  end

  describe '.repo' do
    after { Fuci::Travis.instance_variable_set :@repo, nil }

    describe 'on initial call' do
      before do
        Fuci::Travis.stubs(:remote_repo_name).
          returns @repo_name = 'dj/fuci'
        class Client
          class Repository
            def self.find r
            end
          end
        end
        Fuci::Travis.stubs(:client).returns Client
        Fuci::Travis.expects(:puts).with 'Finding repo...'
      end

      describe 'if the repo can be found' do
        before do
          Client::Repository.stubs(:find).
            with(@repo_name).
            returns @repo = mock
          Fuci::Travis.expects(:puts).with "Using repo: #{@repo_name}"
        end

        it 'logs the query and returns the repo from ::Travis::Pro' do
          expect(Fuci::Travis.repo).to_equal @repo
        end
      end

      describe 'if the repo cannot be found' do
        before do
          Client::Repository.stubs(:find).raises
          Fuci::Travis.expects(:puts).
            with "#{@repo_name} repo could not be found on Travis."
        end

        it "logs that the repo couldn't be found and exits" do
          Fuci::Travis.repo
        end
      end
    end

    describe 'after memoized' do
      before do
        @repo = mock
        Fuci::Travis.instance_variable_set :@repo, @repo
      end

      it 'just returns the repo' do
        Fuci::Travis.expects(:puts).never
        expect(Fuci::Travis.repo).to_equal @repo
      end
    end
  end

  describe '.pro/=' do
    after { Fuci::Travis.instance_variable_set :@pro, false }

    it "is either false or what it's set to" do
      expect(Fuci::Travis.pro).to_equal false
      Fuci::Travis.pro = true
      expect(Fuci::Travis.pro).to_equal true
    end
  end

  describe '.access_token' do
    it 'is an accessor' do
      @access_token = 'access token'
      expect(Fuci::Travis.access_token).to_be_nil
      Fuci::Travis.access_token = @access_token
      expect(Fuci::Travis.access_token).to_equal @access_token
    end
  end

  describe '.add_testers' do
    it 'delegates to Fuci module' do
      testers = [mock, mock]
      Fuci.expects(:add_testers).with testers

      Fuci::Travis.add_testers testers
    end
  end

  describe '.configure' do
    before do
      Fuci::Travis.expects(:puts).with 'configuring'
      Fuci::Travis.expects :set_client
      Fuci::Travis.expects :set_access_token
    end

    it 'yields the block with self, ' +
       'sets the client, ' +
       'and sets the access token' do
      Fuci::Travis.configure do |fu|
        fu.puts 'configuring'
      end
    end
  end

  describe '.set_client' do
    after { Fuci::Travis.instance_variable_set :@client, nil }

    describe 'when pro' do
      before { Fuci::Travis.stubs(:pro).returns true }

      it 'sets the travis strategy to ::Travis::Pro' do
        Fuci::Travis.set_client

        expect(Fuci::Travis.client).to_equal ::Travis::Pro
      end
    end

    describe 'when not pro' do
      before { Fuci::Travis.stubs(:pro).returns false }

      it 'sets the travis strategy to ::Travis' do
        Fuci::Travis.set_client

        expect(Fuci::Travis.client).to_equal ::Travis
      end
    end
  end

  describe '.set_access_token' do
    it 'sets the access token on the client' do
      Fuci::Travis.stubs(:access_token).returns access_token = mock
      Fuci::Travis.stubs(:client).returns client = mock
      client.expects(:access_token=).with access_token

      Fuci::Travis.set_access_token
    end
  end
end
