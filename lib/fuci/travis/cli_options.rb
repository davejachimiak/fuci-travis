module Fuci
  module Travis
    class CliOptions
      PULL_REQUEST_INDICATORS = ['--pull-request', '-p']

      def self.branch
        argv.first
      end

      def self.pull_request?
        (argv & PULL_REQUEST_INDICATORS).any?
      end

      private

      def self.argv
        Fuci::CliOptions.argv
      end
    end
  end
end
