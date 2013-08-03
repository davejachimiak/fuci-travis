module Fuci
  module Travis
    class Build
      class PullRequest < Build
        def build_branch
          repo.builds.detect do |build|
            build.commit.sha == remote_sha_from(branch_name)
          end
        end
      end
    end
  end
end
