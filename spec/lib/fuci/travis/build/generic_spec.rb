require_relative '../../../../spec_helper'
require_relative '../../../../../lib/fuci/travis/build'
require_relative '../../../../../lib/fuci/travis/build/generic'

describe Fuci::Travis::Build::Generic do
  describe 'composition' do
    it 'inherits from Build' do
      generic = Fuci::Travis::Build::Generic.new 'branch'
      expect(generic).to_be_kind_of Fuci::Travis::Build
    end
  end

  describe '#build_branch' do
    before do
      @branch_name = 'my-ci'
      @build       = mock
      Fuci::Travis.stubs(:repo).returns @repo = mock
      @build_wrapper = Fuci::Travis::Build::Generic.new @branch_name
      @build_wrapper.expects(:puts).with "Fetching #{@branch_name} branch..."
    end

    describe 'when the branch is found' do
      before do
        @repo.stubs(:branches).returns branches = { @branch_name => @build }
        @build_wrapper.expects(:puts).with "Using #{@branch_name} branch."
      end

      it 'logs fetching and calls branch hash with the branch_name on the repo' do
        expect(@build_wrapper.send :build_branch ).to_equal @build
      end
    end

    describe 'when branch is not found' do
      before do
        @repo.stubs(:branches).returns branches = {}
        @build_wrapper.expects(:puts).
          with "#{@branch_name} branch not found on Travis."
        @build_wrapper.expects :exit
      end

      it 'logs that the branch could not be found and exits' do
        @build_wrapper.send :build_branch
      end
    end
  end
end
