require "fuci/travis/version"
require 'fuci'
require 'fuci/git'

module Fuci
  module Travis
    include Fuci::Configurable
    extend  Fuci::Git

    class << self
      attr_accessor :default_branch
    end

    def self.repo
      ::Travis::Pro::Repository.find remote_repo_name
    end
  end
end
