require "fuci/travis/version"
require 'fuci'

module Fuci
  module Travis
    include Fuci::Configurable

    ORIGIN_REPO_COMMAND =
      "git remote -v | grep origin | grep push | awk 'match($0, /:(.*\/.*)\./) { print substr($0, RSTART+1, RLENGTH-2) }'"

    class << self
      attr_accessor :default_branch
    end

    def self.repo
      ::Travis::Pro::Repository.find repo_name
    end

    private

    def self.repo_name
      IO.popen origin_repo_command do |io|
        io.first.chomp
      end
    end

    def self.origin_repo_command
      ORIGIN_REPO_COMMAND
    end
  end
end
