module Deploysuite
	class Validator

		def app_not_exist?(host_path)
			host_path.downcase
			if Dir.exists?(host_path)
				DeployLog.stderr_log.fatal {"The app #{host_path} already exists"}
				STDERR.puts Rainbow("ERROR: The app #{host_path} already exists").red
				return false
			else
				true 
			end
		end

		def app_exists?(host_path)
			host_path.downcase
			unless Dir.exists?(host_path)
				STDERR.puts Rainbow("The app #{host_path} does not exist").red	
				return false			
			else
				true
			end
		end

		def repo_exists?(repo)
			command = "git ls-remote #{repo}"
			stdout_str, stderr_str, status = Open3.capture3(command)

			unless status.exitstatus == 0
				DeployLog.stderr_log.fatal {stderr_str}
				STDERR.puts Rainbow(stderr_str).red	
				return false
			else
				return true		
			end
		end

		def path_to_host_legal?(host_path)
			# 'host_path' is the full path to the app i.e., /rails/omh/app1
			# 'path_to_app' is path to div that holds app i.e., /rails/omh
			path_to_host = get_path_to_host(host_path)

			case path_to_host
				when "/rails/omh", "/rails/omh/pilgrim", "/rails/oasas", "/tmp"
					true
			else
				DeployLog.stderr_log.fatal {"'#{path_to_host}' is not a legal path to an app"}
				STDERR.puts Rainbow("ERROR: '#{path_to_host}' is not a legal path to an app").red
				return false
			end
		end

		def get_git_branch(machine_name)
			case machine_name
				when "omhrord1.omh.ny.gov", "marcs-mbp", "u14"
					@git_branch = 'dev'
				when "omhrorq1.omh.ny.gov"
					@git_branch = 'qa'
				when "omhrorp1.omh.ny.gov"
					@git_branch = 'prod'
				else
					STDERR.puts Rainbow("ERROR: This machine '#{machine_name}' does NOT have permission to run this app.").red
					exit 1
			end
		end

		def valid_user?(user, user_group, required_group)
			if user_group.include? required_group
				true
			else
				DeployLog.stderr_log.fatal {"'#{user}' is not a member of '#{required_group}' group on this server"}
				STDERR.puts Rainbow("ERROR: '#{user}' is not a member of '#{required_group}' group on this server").red				
				return false
			end
		end

		def secret_config1?(host_path)
			app_name = get_app_name(host_path)
			secret_config1 = "#{app_name}_enc_application.yml"
			if File.exists?("/rails/#{secret_config1}")
				true
			else
				DeployLog.stderr_log.fatal {" Config file '#{secret_config1}' does not exist"}
				STDERR.puts  Rainbow("ERROR: Config file '#{secret_config1}' does not exist").red 
				return false
			end
		end


		def get_path_to_host(host_path)
			# 'host_path' is the full path to the app i.e., /rails/omh/app1
			# 'path_to_app' is path to div that holds app i.e., /rails/omh
			host_path.downcase
			host_path_array = host_path.split('/')
			host_path_array.pop
			path_to_host = host_path_array.join('/')
		end

		def get_app_name(host_path)
			host_path.downcase
			arr = host_path.split('/')
			app_name = arr.pop
		end
	end
end