module Deploysuite
	class Validator

		def app_not_exist?(host_path)
			host_path.downcase
			if Dir.exists?(host_path)
				DeployLog.stderr_log.fatal {"The app #{host_path} already exists"}
				STDERR.puts "The app #{host_path} already exists"
				return false
			else
				true 
			end
		end

		def app_exists?(host_path)
			host_path.downcase
			unless Dir.exists?(host_path)
				DeployLog.stderr_log.fatal {"The app #{host_path} does not exist"}
				STDERR.puts "The app #{host_path} does not exist"	
				return false			
			else
				true
			end
		end

		def repo_exists?(repo)
			command = "git ls-remote #{repo}"
			stdout_str, stderr_str, status = Open3.capture3(command)

			unless status.exitstatus == 0
				puts "There was an error running '#{command}'"
				DeployLog.stderr_log.fatal {stderr_str}
				STDERR.puts stderr_str	
				return false
			else
				return true		
			end
		end

		def path_to_host_legal?(host_path)
			# path_to_host is directory that contains the app (app = host_path)
			path_to_host = get_path_to_host(host_path)

			case path_to_host
				when "/rails/omh", "/rails/omh/pilgrim", "/rails/oasas", "/tmp"
					true
			else
				DeployLog.stderr_log.fatal {"'#{path_to_host}' is not a legal path to an app"}
				STDERR.puts "'#{path_to_host}' is not a legal path to an app"
				return false
			end
		end

		def get_path_to_host(host_path)
			host_path.downcase
			host_path_array = host_path.split('/')
			host_path_array.pop
			path_to_host = host_path_array.join('/')
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
					STDERR.puts "This machine does NOT HAVE permission to run this script.\
					 						\n\tHostname is: '#{machine_name}' "
					exit 2
			end
		end

		def valid_user?(user, user_group, required_group)
			if user_group.include? required_group
				true
			else
				DeployLog.stderr_log.fatal {"'#{user}' is not a member of '#{required_group}' group on this server"}
				STDERR.puts "'#{user}' is not a member of '#{required_group}' group on this server"				
				return false
			end
		end

		def secret_config1?(host_path)
			app_name = get_app_name(host_path)
			secret_config1 = "#{app_name}_enc_application.yml"
			if File.exists?("/rails/#{secret_config1}")
				true
			else
				DeployLog.stderr_log.fatal {"'#{secret_config1}'' does not exist"}
				STDERR.puts {"'#{secret_config1}'' does not exist"}
				return false
			end
		end

		def get_app_name(host_path)
			host_path.downcase
			arr = host_path.split('/')
			app_name = arr.pop
		end
	end
end