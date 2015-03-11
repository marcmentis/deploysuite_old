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
			@v.valid_user?(@ev.user, @ev.user_groups, "deployer")
			# Check that path to app is legal
			@v.path_to_host_legal?(host_path)
			# Check that app directory does not exist
			@v.app_not_exist?(host_path)
			# Check that Repo exists and user has privileges
			@v.repo_exists?(repo)
		end
		
	end
end