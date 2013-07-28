require 'fuci/travis/version'

require 'fuci'
require 'fuci/git'
require 'fuci/configurable'
require 'fuci/travis/server'

require 'travis'
require 'travis/pro'

require 'forwardable'

module Fuci
  configure do |fu|
    fu.server = Fuci::Travis::Server
  end

  module Travis
    include Fuci::Configurable
    extend  Fuci::Git

    class << self
      extend  Forwardable

      attr_accessor :default_branch, :access_token
      attr_writer   :pro
      def_delegator :Fuci, :add_testers
    end

    def self.repo
      @repo ||= if pro
                  ::Travis::Pro::Repository.find remote_repo_name
                else
                  ::Travis::Repository.find remote_repo_name
                end
    end

    def self.pro
      @pro ||= false
    end
  end
end
