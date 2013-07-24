require_relative '../../spec_helper'
require_relative '../../../lib/fuci/travis'

describe Fuci::Travis do
  describe '.default_branch' do
    after { Fuci::Travis.instance_variable_set :@default_branch, nil }

    it 'is an accessor' do
      @branch = 'branch'
      expect(Fuci::Travis.default_branch).to_be_nil
      Fuci::Travis.default_branch = @branch
      expect(Fuci::Travis.default_branch).to_equal @branch
    end
  end

  describe '.configure' do
    it 'yields the block with self' do
      Fuci::Travis.expects(:puts).with 'configuring!'

      Fuci::Travis.configure do |ft|
        ft.send :puts, 'configuring!'
      end
    end
  end
end
