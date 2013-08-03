module Fuci
  module Travis
    class Build
      module ShaDetectable
        def detect_build_with_sha sha
          repo_builds.detect { |build| commit(build).sha == sha }
        end

        private

        def repo_builds
          repo.builds
        end

        def commit build
          build.commit
        end
      end
    end
  end
end
