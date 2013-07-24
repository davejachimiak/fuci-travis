require 'fuci/server'
require 'forwardable'

module Fuci
  module Travis
    class Server < Fuci::Server
      extend Forwardable

      def_delegator :build, :status, :build_status
      def_delegator :build, :log, :fetch_log
      attr_reader :build

      def initialize
        @build = Fuci::Travis::Build.create
      end
    end
  end
end
