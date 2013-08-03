require_relative '../../../../spec_helper'
require_relative '../../../../../lib/fuci/travis/build/sha_detectable'

stub_class 'SomeBuild'

describe Fuci::Travis::Build::ShaDetectable do
  before { @build = SomeBuild.new.extend Fuci::Travis::Build::ShaDetectable }

  describe '#detect_build_with_sha' do
    it 'returns the build with the same sha as the one passed in' do
      sha    = mock
      commit = OpenStruct.new sha: sha
      build  = OpenStruct.new commit: commit
      builds = [build]
      repo   = OpenStruct.new builds: builds

      @build.stubs(:repo).returns repo

      expect(@build.detect_build_with_sha(sha)).to_equal build
    end
  end
end
