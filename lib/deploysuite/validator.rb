module Deploysuite
	class Validator

		def app_not_exist?(host_path)
			host_path.downcase
			if Dir.exists?(host_path)
				DeployLog.stderr_log.fatal {"The app #{host_path} already exists"}
				STDERR.puts "The app #{host_path} already exists"
				false
				exit 1
			else
				true 
			end
		end

		def app_exists?(host_path)
			host_path.downcase
			unless Dir.exists?(host_path)
				DeployLog.stderr_log.fatal {"The app #{host_path} does not exist"}
				STDERR.puts "The app #{host_path} does not exist"
				false
				exit 1
			else
				true
			end
		end

		def repo_exists?(repo)
			command = "git ls-remote #{repo}"
			stdout_str, stderr_str, status = Open3.capture3(command)
			DeployLog.stdout_log.info {"Command: \n\t'#{command}'\n #{stdout_str}"}
			STDOUT.puts stdout_str
			return true

			unless status.exitstatus == 0
				puts "There was an error running '#{command}'"
				DeployLog.stderr_log.fatal {stderr_str}
				STDERR.puts stderr_str
				false
				exit 1
			end
		end

		def path_to_host_legal?(host_path)
			host_path_array = host_path.split('/')
			host_path_array.pop
			path_to_host = host_path_array.join('/')

			case path_to_host
				when "/rails/omh", "/rails/omh/pilgrim", "/rails/oasas", "/tmp"
					true
			else
				false
				DeployLog.stderr_log.fatal {"'#{path_to_host}' is not a legal path to an app"}
				STDERR.puts "'#{path_to_host}' is not a legal path to an app"
				exit 1
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
					STDERR.puts "This machine does NOT HAVE permission to run this script.\
					 						\n\tHostname is: '#{machine_name}' "
					exit 2
			end
		end
	end
end