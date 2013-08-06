module Fuci
  module Travis
    class Build
      class Generic < Build
        def build_branch
          puts "Fetching #{branch_name} branch..."
          if branch = repo.branches[branch_name]
            puts "Using #{branch_name} branch."
            branch
          else
            puts "#{branch_name} branch not found on Travis."
            exit
          end
        end
      end
    end
  end
end
