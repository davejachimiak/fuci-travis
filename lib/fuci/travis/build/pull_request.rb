require 'fuci/travis/build/sha_detectable'

module Fuci
  module Travis
    class Build
      class PullRequest < Build
        include ShaDetectable

        def build_branch
          if branch = detect_build_with_sha(remote_sha_from(branch_name))
            branch.pull_request? ? branch : log_not_a_pull_request
          else
            puts "No build was detected for a pull request from #{branch_name}."
            exit
          end
        end

        private

        def log_not_a_pull_request
          puts "No build has been triggered by a pull request from #{branch_name}."
          exit
        end
      end
    end
  end
end
