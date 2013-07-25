require "fuci/travis/version"
require 'fuci'

module Fuci
  module Travis
    include Fuci::Configurable

    class << self
      attr_accessor :default_branch
    end

    def self.repo
      ::Travis::Pro::Repository.find repo_name
    end
  end
end
