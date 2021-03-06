require_relative '../../../spec_helper'
require_relative '../../../../lib/fuci/travis/build'

stub_class 'Fuci::Travis::Build::Master'
stub_class 'Fuci::Travis::Build::PullRequest'
stub_class 'Fuci::Travis::CliOptions' do
  public
  def branch; end;
end

describe Fuci::Travis::Build do
  describe '#initialize' do
    it 'sets the branch name' do
      build = Fuci::Travis::Build.new branch_name = 'name'
      expect(build.branch_name).to_equal branch_name
    end
  end

  describe '#branch' do
    it 'sets a memoized branch with build_branch' do
      build = Fuci::Travis::Build.new 'name'
      build.stubs(:build_branch).returns branch = mock
      expect(build.branch).to_equal branch
    end
  end

  describe '#status' do
    before do
      Fuci::Travis::Build.any_instance.stubs(:build_branch).
        returns branch = mock
      @build = Fuci::Travis::Build.new ''
      @state = @build.branch.stubs :state
    end

    describe 'when the build passed' do
      it 'returns :green' do
        green = :green
        @state.returns 'passed'

        expect(@build.status).to_equal green
      end
    end

    describe 'when the build failed' do
      it 'returns :red' do
        red = :red
        @state.returns 'failed'

        expect(@build.status).to_equal red
      end
    end

    describe 'when the build neither passed nor failed' do
      it 'returns :yellow' do
        yellow = :yellow
        expect(@build.status).to_equal yellow
      end
    end
  end

  describe '#log' do
    it 'returns the log body from the build' do
      Fuci::Travis::Build.any_instance.
        stubs(:build_branch).
        returns branch = mock

      build    = Fuci::Travis::Build.new ''
      log_body = 'brody'
      log      = OpenStruct.new(body: log_body)
      jobs     = [OpenStruct.new(log: log)]

      build.branch.stubs(:jobs).returns jobs

      expect(build.log).to_equal log_body
    end
  end

  describe '.create' do
    before do
      @pull_request    = Fuci::Travis::CliOptions.stubs :pull_request?
      @branch_from_cli = Fuci::Travis::CliOptions.stubs :branch
      @expect_from_branch_name = Fuci::Travis::Build.expects :from_branch_name
    end

    describe 'a pull request option is declared from the command line' do
      before do
        @pull_request.returns true
        @expect_from_branch_name.never
        @pull_request_branch =
          Fuci::Travis::CliOptions.stubs :pull_request_branch
      end

      describe 'when a pull request branch is declared' do
        before do
          @branch_name = 'branch_name'
          @pull_request_branch.returns @branch_name
        end

        it 'instantiates pull request build with the branch' do
          Fuci::Travis::Build::PullRequest.expects(:new).
            with @branch_name

          Fuci::Travis::Build.create
        end
      end

      describe 'when a pull request branch is not declared' do
        before do
          @pull_request_branch.returns nil
          Fuci::Travis::Build.stubs(:current_branch_name).
            returns @current_branch_name = 'current_branch_name'
        end

        it 'instantiates a pull request build with the current branch name' do
          Fuci::Travis::Build::PullRequest.expects(:new).
            with @current_branch_name

          Fuci::Travis::Build.create
        end
      end
    end

    describe 'a branch option is declared from the command line' do
      before do
        @branch = 'master'
        @branch_from_cli.returns @branch
      end

      it 'takes priority' do
        @expect_from_branch_name.with @branch
        Fuci::Travis::Build.create
      end
    end

    describe 'a branch option is not declared from the command line' do
      describe 'a default branch is specfied on Fuci::Travis' do
        before do
          @branch = 'dj-ci'
          Fuci::Travis.stubs(:default_branch).returns @branch
        end

        it 'creates a new ::Build with the default branch' do
          @expect_from_branch_name.with @branch
          Fuci::Travis::Build.create
        end
      end

      describe 'a default branch is not specified on Fuci::Travis' do
        before { Fuci::Travis.stubs(:default_branch).returns nil }

        it 'creates a new ::Build with the current branch' do
          Fuci::Travis::Build.
            stubs(:current_branch_name).
            returns branch_name = mock
          @expect_from_branch_name.with branch_name
          Fuci::Travis::Build.create
        end
      end
    end
  end

  describe '.from_branch_name' do
    describe 'the branch name is master' do
      before { @branch_name = 'master' }

      it 'creates a new Master build' do
        Fuci::Travis::Build::Master.stubs(:new).returns master_build = mock
        build = Fuci::Travis::Build.from_branch_name @branch_name
        expect(build).to_equal master_build
      end
    end

    describe 'the branch name is not master' do
      before { @branch_name = 'limb' }

      it 'creates a new generic build' do
        Fuci::Travis::Build::Generic.stubs(:new).with(@branch_name).
          returns generic_build = mock
        build = Fuci::Travis::Build.from_branch_name @branch_name
        expect(build).to_equal generic_build
      end
    end
  end

  describe '#build_branch' do
    it 'raises not implemented' do
      build = Fuci::Travis::Build.new 'branch'
      expect { build.build_branch }.to_raise NotImplementedError
    end
  end
end
