require_relative '../../../../spec_helper'
require_relative '../../../../../lib/fuci/travis/build'
require_relative '../../../../../lib/fuci/travis/build/master'

describe Fuci::Travis::Build::Master do
  before do
    @master = Fuci::Travis::Build::Master.new
  end

  describe 'composition' do
    it 'inherits from ::Travis::Build' do
      expect(@master).to_be_kind_of Fuci::Travis::Build
    end
  end

  describe '#build_branch' do
    it 'detects the build branch' do
      Fuci::Travis.stubs(:repo).returns repo = mock

      @master.stubs(:remote_master_sha).returns master_sha = '123abc'
      commit = OpenStruct.new(sha: master_sha)
      build  = OpenStruct.new(commit: commit)
      repo.stubs(:builds).returns [build]

      expect(@master.build_branch).to_equal build
    end
  end
end
