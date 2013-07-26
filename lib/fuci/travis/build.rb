require 'forwardable'
require 'fuci/git'

module Fuci
  module Travis
    class Build
      extend Forwardable
      extend Fuci::Git

      CURRENT_BRANCH_COMMAND = "git branch | sed -n '/\* /s///p'"
      FAILED                 = 'failed'
      PASSED                 = 'passed'

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
        branch_name =
          Fuci.options[:branch]       ||
          Fuci::Travis.default_branch ||
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
        repo.branches[branch_name]
      end

      def repo
        Fuci::Travis.repo
      end
    end
  end
end
