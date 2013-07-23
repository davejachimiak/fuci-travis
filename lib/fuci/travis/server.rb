require 'fuci/server'

module Fuci
  module Travis
    class Server < Fuci::Server
      def build_status
        build.build_status
      end
    end
  end
end
