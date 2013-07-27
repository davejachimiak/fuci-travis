require 'fuci/travis/version'

require 'fuci'
require 'fuci/git'
require 'fuci/configurable'
require 'fuci/travis/server'

require 'travis/pro'

module Fuci
  configure do |fu|
    fu.server = Fuci::Travis::Server
  end

  module Travis
    include Fuci::Configurable
    extend  Fuci::Git

    class << self
      attr_accessor :default_branch
    end

    def self.repo
      @repo ||= ::Travis::Pro::Repository.find remote_repo_name
    end
  end
end
