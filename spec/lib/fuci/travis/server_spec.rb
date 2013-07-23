require_relative '../../../spec_helper'
require_relative '../../../../lib/fuci/travis/server'

describe Fuci::Travis::Server do
  before { @server = Fuci::Travis::Server.new }

  describe 'composition' do
    it 'inherits from Fuci::Server' do
      server = Fuci::Travis::Server.new
      expect(server).to_be_kind_of Fuci::Server
    end
  end

  describe '#build_status' do
    it 'delegates to the build object' do
      @server.stubs(:build).
        returns OpenStruct.new build_status: build_status = mock

      expect(@server.build_status).to_equal build_status
    end
  end
end
