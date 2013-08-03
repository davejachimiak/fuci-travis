require_relative '../../../../spec_helper'
require_relative '../../../../../lib/fuci/travis/build'
require_relative '../../../../../lib/fuci/travis/build/pull_request'

describe Fuci::Travis::Build::PullRequest do
  before do
    @branch_name  = 'branch'
    @pull_request = Fuci::Travis::Build::PullRequest.new @branch_name
  end

  describe 'composition' do
    it 'inherits from Build' do
      expect(@pull_request).to_be_kind_of Fuci::Travis::Build
    end
  end

  describe '#build_branch' do
    it 'fetches the build with the remote sha of the branch name' do
      @pull_request.stubs(:remote_sha_from).
        with(@branch_name).
        returns sha = mock

      @pull_request.stubs(:detect_build_with_sha).
        with(sha).
        returns build = mock

      expect(@pull_request.build_branch).to_equal build
    end
  end
end
