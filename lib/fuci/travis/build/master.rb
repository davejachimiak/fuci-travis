module Fuci
  module Travis
    class Build
      class Master < Build
        def initialize; end;

        def build_branch
          repo.builds.detect do |build|
            build.commit.sha == remote_master_sha
          end
        end
      end
    end
  end
end
