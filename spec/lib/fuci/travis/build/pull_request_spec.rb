require_relative '../../../../spec_helper'
require_relative '../../../../../lib/fuci/travis/build'
require_relative '../../../../../lib/fuci/travis/build/pull_request'

describe Fuci::Travis::Build::PullRequest do
  describe 'composition' do
    it 'inherits from Build' do
      pull_request = Fuci::Travis::Build::PullRequest.new ''
      expect(pull_request).to_be_kind_of Fuci::Travis::Build
    end
  end
end
