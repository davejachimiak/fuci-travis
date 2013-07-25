require 'fuci/server'
require 'forwardable'

module Fuci
  module Travis
    class Server < Fuci::Server
      extend Forwardable

      attr_reader   :build
      def_delegator :build, :status, :build_status
      def_delegator :build, :log

      def initialize
        @build = Fuci::Travis::Build.create
      end

      def fetch_log
        remove_ascii_color_chars log
      end
    end
  end
end
