module Deploysuite
	class Runner
		def run_clone(repo, host_path)
			# # Validations:
			# 	v = Validator.new
			# 	# Check that app directory does not exist
			# 	v.app_should_not_exist(host_path)
			# 	# Check that Repo exists and user has privileges
			# 	v.repo_exists(repo)
			# 	# Get log file path
			#     # log_path = v.get_log_path(host_path)

			# # Get env_values
			# env_values = EnvValues.new
		 #    machine_name = env_values.machine_name
		 #    git_branch = env_values.get_git_branch

		    # Run clone
		    g = GitProxy.new
		    git_branch = 'dev'
		    g.clone(git_branch, repo, host_path)

		    # Log
		end
		
	end
end