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
    before do
      @pull_request.stubs(:remote_sha_from).
        with(@branch_name).
        returns @sha = mock
    end

    describe 'when no build is detected' do
      before do
        @pull_request.stubs(:detect_build_with_sha).
          with(@sha).
          returns nil
      end

      it 'logs that no build was detected for the branch and exits' do
        @pull_request.expects(:puts).
          with "No build was detected for a pull request from #{@branch_name}."
        @pull_request.expects(:exit)

        @pull_request.build_branch
      end
    end

    describe 'when a build is detected' do
      describe 'build detected is not a pull request' do
        before do
          @pull_request.stubs(:detect_build_with_sha).
            with(@sha).
            returns @build = OpenStruct.new(pull_request?: false)
        end

        it 'logs that the branch has no pull request and exits' do
          @pull_request.expects(:puts).
            with "No build has been triggered by a pull request from #{@branch_name}."
          @pull_request.expects(:exit)

          @pull_request.build_branch
        end
      end

      describe 'build detected is a pull request' do
        before do
          @pull_request.stubs(:detect_build_with_sha).
            with(@sha).
            returns @build = OpenStruct.new(pull_request?: true)
        end

        it 'fetches the build with the remote sha of the branch name' do
          expect(@pull_request.build_branch).to_equal @build
        end
      end
    end
  end
end
