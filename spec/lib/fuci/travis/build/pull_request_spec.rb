require_relative '../../../../spec_helper'
require_relative '../../../../../lib/fuci/travis/build'
require_relative '../../../../../lib/fuci/travis/build/pull_request'

module Fuci
  module Git
    class NoPullError < StandardError
    end
  end
end

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
      @pull_merge_sha_from = @pull_request.
        stubs(:pull_merge_sha_from).
        with @branch_name
    end

    describe 'there is no pull request for the branch' do
      before do
        @pull_merge_sha_from.raises Fuci::Git::NoPullError
      end

      it 'logs that no pull request was detected for the branch and exits' do
        @pull_request.expects(:puts).
          with "No pull request was detected for #{@branch_name}."
        @pull_request.expects(:exit)

        @pull_request.build_branch
      end
    end

    describe 'there is a pull request for the branch' do
      before do
        @pull_merge_sha_from.returns @sha = '23iadf89wro'
        @detect_build_with_sha = @pull_request.
          stubs(:detect_build_with_sha).with @sha
      end

      describe 'a build was not detected for the pull request' do
        before do
          @detect_build_with_sha.with(@sha).returns nil
        end

        it 'logs that no build was detected with pull request and exits' do
          @pull_request.expects(:puts).
            with "No build was detected for pull request from #{@branch_name}."
          @pull_request.expects(:exit)

          @pull_request.build_branch
        end
      end

      describe 'a build was detected for the pull request' do
        before do
         @detect_build_with_sha.returns @build = mock
        end

        it 'returns the build' do
          expect(@pull_request.build_branch).to_equal @build
        end
      end
    end
  end
end
