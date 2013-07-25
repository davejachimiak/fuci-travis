module Fuci
  module Travis
    class Build
      CURRENT_BRANCH_COMMAND = "git branch | sed -n '/\* /s///p'"
      attr_reader :branch

      def initialize branch=current_branch
        @branch = branch
      end

      def self.create
        if command_line_branch = Fuci.options[:branch]
          new command_line_branch
        elsif default_branch = Fuci::Travis.default_branch
          new default_branch
        else
          new
        end
      end

      private

      def current_branch
        IO.popen current_branch_command do |io|
          io.first.chomp
        end
      end

      def current_branch_command
        CURRENT_BRANCH_COMMAND
      end
    end
  end
end
