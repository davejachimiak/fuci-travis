require 'fuci'
require 'fuci/git'
require 'fuci/configurable'
require 'fuci/travis/server'
require 'fuci/travis/version'

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

    DEFAULT_CLIENT = ::Travis
    PRO_CLIENT     = ::Travis::Pro

    class << self
      extend  Forwardable

      attr_accessor :default_branch, :access_token
      attr_writer   :pro
      def_delegator :Fuci, :add_testers
    end

    def self.repo
      return @repo if @repo
      puts 'Finding repo...'
      @repo = client.find remote_repo_name
      puts "Using repo: #{remote_repo_name}"
      @repo
    end

    def self.pro
      @pro ||= false
    end

    def self.configure
      super
      set_client
      set_access_token
    end

    private

    def self.set_client
      @client = PRO_CLIENT if pro
    end

    def self.client
      @client ||= DEFAULT_CLIENT
    end

    def self.set_access_token
      client.access_token = access_token
    end
  end
end
