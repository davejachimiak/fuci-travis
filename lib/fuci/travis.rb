require "fuci/travis/version"

module Fuci
  module Travis
    class << self
      attr_accessor :default_branch
    end

    def self.configure
      yield self
    end
  end
end
