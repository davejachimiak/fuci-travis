require 'fuci/travis/build/sha_detectable'

module Fuci
  module Travis
    class Build
      class PullRequest < Build
        include ShaDetectable

        def build_branch
          detect_build_with_sha remote_sha_from(branch_name)
        end
      end
    end
  end
end
