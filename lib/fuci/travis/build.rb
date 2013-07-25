module Fuci
  module Travis
    class Build
      CURRENT_BRANCH_COMMAND = "git branch | sed -n '/\* /s///p'"

      attr_reader :branch

      def initialize branch_name
        @branch = build_branch branch_name
      end

      def self.create
        branch_name =
          Fuci.options[:branch] ||
          Fuci::Travis.default_branch ||
          current_branch_name

        from_branch_name branch_name
      end

      def self.from_branch_name branch_name
        if branch_name == 'master'
          Fuci::Travis::Build::Master.new
        else
          new
        end
      end

      private

      def build_branch branch_name
        Fuci::Travis.repo.branches[branch_name]
      end

      def self.current_branch_name
        IO.popen current_branch_command do |io|
          io.first.chomp
        end
      end

      def self.current_branch_command
        CURRENT_BRANCH_COMMAND
      end
    end
  end
end
