module Deploysuite
	class Runner
		def initialize
			@v = Validator.new
			@ev = EnvValues.new
			@g = GitProxy.new
		end

		def run_clone_branch(repo, host_path)
		    git_branch = @v.get_git_branch(@ev.machine_name)
		    @g.clone_branch(git_branch, repo, host_path)
		end

		def run_validate_for_clone_branch(repo, host_path)
			# Check that user is member of 'deployers' group
			unless @v.valid_user?(@ev.user, @ev.user_groups, "deployer")			
				exit 1
			end
			
			# Check that path to app is legal
			unless @v.path_to_host_legal?(host_path)
				exit 1
			end
			
			# Check that app directory does not exist
			unless @v.app_not_exist?(host_path)
				exit 1
			end
			
			# Check that Repo exists and user has privileges
			unless @v.repo_exists?(repo)
				exit 1
			end
		end
		
	end
end