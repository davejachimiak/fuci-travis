module Fuci
  module Travis
    class CliOptions
      def self.branch
        argv.first
      end

      private

      def self.argv
        Fuci::CliOptions.argv
      end
    end
  end
end
