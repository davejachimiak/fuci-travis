require 'fuci/travis/build/sha_detectable'

module Fuci
  module Travis
    class Build
      class PullRequest < Build
        include ShaDetectable

        def build_branch
          sha = begin
                  pull_merge_sha_from branch_name
                rescue Fuci::Git::NoPullError
                  puts "No pull request was detected for #{branch_name}."
                  return exit
                end

          if branch = detect_build_with_sha(sha)
            branch
          else
            puts "No build was detected for pull request from #{branch_name}."
            exit
          end
        end
      end
    end
  end
end
