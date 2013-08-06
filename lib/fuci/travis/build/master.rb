require 'fuci/travis/build/sha_detectable'

module Fuci
  module Travis
    class Build
      class Master < Build
        include ShaDetectable

        def initialize; end;

        def build_branch
          detect_build_with_sha remote_master_sha
        end
      end
    end
  end
end
