require_relative '../../spec_helper'
require_relative '../../../lib/fuci/travis'

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
    it 'is the Travis Repo' do
      Fuci::Travis.stubs(:remote_repo_name).returns repo_name = 'owner/lib'
      Travis::Pro::Repository.stubs(:find).
        with(repo_name).
        returns repo = mock

      expect(Fuci::Travis.repo).to_equal repo
    end
  end
end
