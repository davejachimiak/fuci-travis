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
    before do
      @pro  = Fuci::Travis.stubs :pro
      @repo = mock
      Fuci::Travis.stubs(:remote_repo_name).
        returns @repo_name = 'owner/lib'
    end

    after { Fuci::Travis.instance_variable_set :@repo, nil }

    describe 'when pro' do
      before { @pro.returns true }

      it 'returns the repo from ::Travis::Pro' do
        Travis::Pro::Repository.stubs(:find).
          with(@repo_name).
          returns @repo

        expect(Fuci::Travis.repo).to_equal @repo
      end
    end

    describe 'when not pro' do
      before { @pro.returns false }

      it 'returns the repo form ::Travis' do
        Travis::Repository.stubs(:find).
          with(@repo_name).
          returns @repo

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
end
