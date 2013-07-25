require_relative '../../../../spec_helper'
require_relative '../../../../../lib/fuci/travis/build/master'

describe Fuci::Travis::Build::Master do
  describe 'composition' do
    it 'inherits from ::Travis::Build' do
      master = Fuci::Travis::Build::Master.new
      expect(master).to_be_kind_of Fuci::Travis::Build
    end
  end
end
