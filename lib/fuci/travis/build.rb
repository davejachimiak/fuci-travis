require 'forwardable'
require 'fuci/git'
require 'fuci/travis/cli_options'
require 'fuci/travis/build/master'

module Fuci
  module Travis
    class Build
      extend  Forwardable, Fuci::Git
      include Fuci::Git

      FAILED = 'failed'
      PASSED = 'passed'

      attr_reader    :branch_name
      def_delegators :branch, :state, :jobs

      def initialize branch_name
        @branch_name = branch_name
      end

      def branch
        @branch ||= build_branch
      end

      def status
        case state
        when FAILED
          :red
        when PASSED
          :green
        else
          :yellow
        end
      end

      def log
        jobs.first.log.body
      end

      def self.create
        if Fuci::Travis::CliOptions.pull_request?
          branch_name =
            Fuci::Travis::CliOptions.pull_request_branch || current_branch_name

          return Fuci::Travis::Build::PullRequest.new branch_name
        end

        branch_name =
          Fuci::Travis::CliOptions.branch ||
          Fuci::Travis.default_branch     ||
          current_branch_name

        from_branch_name branch_name
      end

      def self.from_branch_name branch_name
        if branch_name == 'master'
          Fuci::Travis::Build::Master.new
        else
          new branch_name
        end
      end

      private

      def build_branch
        puts "Fetching #{branch_name} branch..."
        if branch = repo.branches[branch_name]
          puts "Using #{branch_name} branch."
          branch
        else
          puts "#{branch_name} branch not found on Travis."
          exit
        end
      end

      def repo
        Fuci::Travis.repo
      end
    end
  end
end
