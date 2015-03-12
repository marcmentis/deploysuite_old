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
		    STDOUT.puts "Success: '#{repo}' cloned into '#{host_path}'"
		end

		# VALIDATIONS
		# Check that app directory does not exist
		def run_app_not_exist?(host_path)
			if @v.app_not_exist?(host_path)
				STDOUT.puts "Success: No pre-existig app at '#{host_path}'"
			else
				exit 1
			end
		end

		# Check that user is member of 'deployers' group
		def run_valid_user?
			if @v.valid_user?(@ev.user, @ev.user_groups, "deployer")
				STDOUT.puts "Success: '#{@ev.user}' is member of 'deployer' group"
			else
				exit 1
			end
		end

		# Check that path to app is legal
		def run_path_to_host_legal?(host_path)
			if @v.path_to_host_legal?(host_path)
				STDOUT.puts "Success: '#{host_path}' is legal path for app"
			else
				exit 1
			end
		end

		# Check that Repo exists and user has privileges
		def run_repo_exists?(repo)
			if @v.repo_exists?(repo)
				STDOUT.puts "Success: '#{repo}' exists and '#{@ev.user}' has privileges"
			else
				exit 1
			end
		end
			
	end
end