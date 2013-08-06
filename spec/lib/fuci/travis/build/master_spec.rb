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
      @master.stubs(:remote_master_sha).
        returns remote_master_sha = mock
      @master.stubs(:detect_build_with_sha).
        with(remote_master_sha).
        returns build = mock
      expect(@master.build_branch).to_equal build
    end
  end
end
