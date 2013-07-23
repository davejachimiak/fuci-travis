require_relative '../../../spec_helper'

stub_class 'Fuci::Server'
require_relative '../../../../lib/fuci/travis/server'

describe Fuci::Travis::Server do
  describe 'composition' do
    it 'inherits from Fuci::Server' do
      server = Fuci::Travis::Server.new
      expect(server).to_be_kind_of Fuci::Server
    end
  end
end
