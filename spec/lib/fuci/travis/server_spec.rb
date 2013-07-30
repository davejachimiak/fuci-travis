require_relative '../../../spec_helper'
require_relative '../../../../lib/fuci/travis/server'

describe Fuci::Travis::Server do
  before do
    Fuci::Travis::Build.stubs(:create).returns @build = mock
    @server = Fuci::Travis::Server.new
  end

  describe 'composition' do
    it 'inherits from Fuci::Server' do
      expect(@server).to_be_kind_of Fuci::Server
    end
  end

  describe '#initialize' do
    it 'sets a build instance' do
      server = Fuci::Travis::Server.new
      expect(server.build).to_equal @build
    end
  end

  describe '#build_status' do
    it 'delegates to the build object' do
      @server.stubs(:build).
        returns OpenStruct.new status: build_status = mock

      expect(@server.build_status).to_equal build_status
    end
  end

  describe '#fetch_log' do
    it 'delegates to the build object' do
      @server.stubs(:build).
        returns OpenStruct.new log: log = mock
      @server.stubs(:remove_ascii_color_chars).
        with(log).
        returns sanitized_log = mock

      expect(@server.fetch_log).to_equal sanitized_log
    end
  end
end
