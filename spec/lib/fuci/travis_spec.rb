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
      Fuci::Travis.stubs(:repo_name).returns repo_name = 'owner/lib'
      Travis::Pro::Repository.stubs(:find).
        with(repo_name).
        returns repo = mock

      expect(Fuci::Travis.repo).to_equal repo
    end
  end

  describe '.repo_name' do
    it 'is the git repository name from the origin' do
      repo_name = 'owner/lib'
      Fuci::Travis.
        stubs(:origin_repo_command).
        returns "echo #{repo_name}"

      expect(Fuci::Travis.send :repo_name ).to_equal repo_name
    end
  end

  describe '.origin_repo_command' do
    it 'should be this' do
      command = "git remote -v | grep origin | grep push | awk 'match($0, /:(.*\/.*)\./) { print substr($0, RSTART+1, RLENGTH-2) }'"
      expect(Fuci::Travis.origin_repo_command).to_equal command
    end
  end
end
