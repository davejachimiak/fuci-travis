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

      def self.pull_request_branch
        branch = nil

        argv.each_with_index do |arg, index|
          if PULL_REQUEST_INDICATORS.include? arg
            branch = argv[index+1]
          end
        end

        branch
      end

      private

      def self.argv
        Fuci::CliOptions.argv
      end
    end
  end
end
