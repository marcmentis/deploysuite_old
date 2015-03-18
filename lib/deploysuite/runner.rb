module Deploysuite
	class Runner
		attr_reader :v, :ev, :g, :u, :r

		def initialize(args)
			@v = args[:validator] 
			@ev = args[:env_values] 
			@g = args[:git_proxy] 
			@u = args[:utils_proxy]
			@r = args[:rails_proxy]
		end

		def run_move_secret_file(host_path)
			app_name = v.get_app_name(host_path)
			file = "/rails/#{app_name}_enc_application.yml"
			final_path = "#{host_path}/config/enc_application.yml"
			u.move_secret_file(file, host_path)

			STDOUT.puts Rainbow("Success: #{file} moved to #{final_path}").green
		end

		def run_set_app_privileges_ownership(host_path)
			final_deployer_group = v.get_final_deployer_group(host_path)
			u.set_app_group_ownership(host_path, final_deployer_group)
			u.set_app_permissions(host_path)
			app_name = v.get_app_name(host_path)

			STDOUT.puts Rainbow("Success: Group ownership and privileges set for #{app_name}").green
		end

		# VALIDATIONS
		# Check that app directory does not exist
		def run_app_not_exist?(host_path)
			if v.app_not_exist?(host_path)
				STDOUT.puts Rainbow("Success: No pre-existig app at '#{host_path}'").green
			else
				exit 1
			end
		end

		# Check that user is member of 'final_deployer_group'
		def run_in_final_deployer_group?(host_path)
			path_to_host = v.get_path_to_host(host_path)
			if v.in_final_deployer_group?(ev.user, ev.user_groups, host_path)
				STDOUT.puts Rainbow("Success: '#{ev.user}' is member of '#{path_to_host}' group").green
			else
				
			end
		end

		# Check that user is member of 'deployers' group
		def run_valid_user?
			if v.valid_user?(ev.user, ev.user_groups, "railsdep")
				STDOUT.puts Rainbow("Success: '#{ev.user}' is member of 'railsdep' group").green
			else
				exit 1
			end
		end

		# Check that path to app is legal
		def run_path_to_host_legal?(host_path)
			if v.path_to_host_legal?(host_path)
				path_to_host = v.get_path_to_host(host_path)
				STDOUT.puts Rainbow("Success: '#{path_to_host}' is legal path for app").green
			else
				exit 1
			end
		end

		# Check that Repo exists and user has privileges
		def run_repo_exists?(repo)
			if v.repo_exists?(repo)
				STDOUT.puts Rainbow("Success: '#{repo}' exists and '#{ev.user}' has privileges").green
			else
				exit 1
			end
		end

		# Check that secret_config1 file exists
		def run_secret_config1?(host_path)
			if v.secret_config1?(host_path)
				STDOUT.puts Rainbow("Success: secret_config1 exists").green
			else
				exit 1
			end
		end

		def run_clone_branch(repo, host_path)
		    git_branch = v.get_git_branch(ev.machine_name)
		    g.clone_branch(git_branch, repo, host_path)
		    STDOUT.puts Rainbow("Success: '#{repo}' cloned into '#{host_path}'").green
		end

		def run_check_pwd(host_path)
			r.check_pwd(host_path)
			STDOUT.puts Rainbow("Success: 'deploysuite' run from root dir of app: '#{host_path}'").green
		end

		def run_bundle
			r.bundle
			STDOUT.puts Rainbow("Success: Production env 'bundle' command run for app").green
		end

		def run_precompile_assets
			r.precompile_assets
			STDOUT.puts Rainbow("Success: Production env assets precompiled for app").green
		end

		def run_first_commit
			r.first_commit
			STDOUT.puts Rainbow("Success: First Commit performed for app").green
		end

		def run_start_application
			r.start_application
			STDOUT.puts Rainbow("Success: Application restarted").green
		end

		
			
	end
end