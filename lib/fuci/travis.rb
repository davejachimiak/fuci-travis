require 'fuci/travis/version'

require 'fuci'
require 'fuci/git'
require 'fuci/configurable'
require 'fuci/travis/server'

module Fuci
  configure do |fu|
    fu.server = Fuci::Travis::Server
  end

  module Travis
    include Fuci::Configurable
    extend  Fuci::Git

    class << self
      attr_accessor :default_branch, :access_token
    end

    def self.repo
      @repo ||= if pro
                  require 'travis/pro'
                  ::Travis::Pro::Repository.find remote_repo_name
                else
                  require 'travis'
                  ::Travis::Repository.find remote_repo_name
                end
    end

    def self.pro
      @pro ||= false
    end

    def self.pro= boolean
      @pro = boolean
    end
  end
end
