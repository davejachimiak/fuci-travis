require_relative '../../../spec_helper'
require_relative '../../../../lib/fuci/travis/build'

describe Fuci::Travis::Build do
  describe '#initialize' do
    describe 'if a branch is passed in' do
      it 'sets it to #branch' do
        build = Fuci::Travis::Build.new branch = mock
        expect(build.branch).to_equal branch
      end
    end

    describe 'if a branch is not passed in' do
      it 'sets #branch to the current branch' do
        Fuci::Travis::Build.any_instance.
          stubs(:current_branch).
          returns branch = mock
        build = Fuci::Travis::Build.new
        expect(build.branch).to_equal branch
      end
    end
  end

  describe '.create' do
    before do
      @expect_new_build = Fuci::Travis::Build.expects :new
    end

    describe 'a branch option is declared from the command line' do
      before do
        @branch = 'master'
        Fuci.stubs(:options).returns branch: @branch
      end

      it 'takes priority' do
        @expect_new_build.with @branch
        Fuci::Travis::Build.create
      end
    end

    describe 'a branch option is not declared from the command line' do
      before { Fuci.stubs(:options).returns branch: nil }

      describe 'a default branch is specfied on Fuci::Travis' do
        before do
          @branch = 'dj-ci'
          Fuci::Travis.stubs(:default_branch).returns @branch
        end

        it 'creates a new ::Build with the default branch' do
          @expect_new_build.with @branch
          Fuci::Travis::Build.create
        end
      end

      describe 'a default branch is not specified on Fuci::Travis' do
        before { Fuci::Travis.stubs(:default_branch).returns nil }

        it 'creates a new ::Build with nothing' do
          @expect_new_build.with
          Fuci::Travis::Build.create
        end
      end
    end
  end
end
