module Fuci
  module Travis
    class Build
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
    end
  end
end
