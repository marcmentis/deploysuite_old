module Deploysuite
	class Runner
		def run_clone(repo, host_path)
			# Validations:
				v = Validator.new
				# Check that path to app is legal
				v.path_to_host_legal?(host_path)
				# Check that app directory does not exist
				v.app_not_exist?(host_path)
				# Check that Repo exists and user has privileges
				v.repo_exists?(repo)

			# Get env_values
			env_values = EnvValues.new
		    machine_name = env_values.machine_name
		    git_branch = env_values.get_git_branch

		    # Run clone
		    g = GitProxy.new
		    g.clone(git_branch, repo, host_path)

		    # Log
		end
		
	end
end