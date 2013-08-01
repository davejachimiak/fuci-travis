require_relative '../../../spec_helper'
require_relative '../../../../lib/fuci/travis/cli_options'

stub_class 'Fuci::CliOptions'

describe Fuci::Travis::CliOptions do
  describe '.branch' do
    it 'returns the first argument to the command line' do
      branch = 'branch'
      Fuci::Travis::CliOptions.stubs(:argv).returns [branch]
      expect(Fuci::Travis::CliOptions.branch).to_equal branch
    end

    it 'returns nil if argv is empty' do
      Fuci::Travis::CliOptions.stubs(:argv).returns []
      expect(Fuci::Travis::CliOptions.branch).to_be_nil
    end
  end

  describe '.argv' do
    it 'delegates to Fuci::CliOptions' do
      Fuci::CliOptions.stubs(:argv).returns argv = mock
      expect(Fuci::Travis::CliOptions.argv).to_equal argv
    end
  end
end
