
# require 'rainbow'
module Deploysuite
	class UtilsProxy
		def check_pwd(host_path)
			pwd = `pwd`.chomp
			unless pwd == host_path
				DeployLog.stderr_log.fatal {"ERROR: Need to run 'deploysuite' from within app root: '#{host_path}'"}
				STDERR.puts Rainbow("ERROR: Need to run 'deploysuite' from within app root: '#{host_path}'").red
				exit 1
			end
		end

		def start_application
			cmd = "touch tmp/restart.txt"
			process_cmd(cmd,'stdout')
			# STDOUT.puts stdout_str	
		end

		def move_secret_file(file, host_path)
			final_path = "#{host_path}/config/enc_application.yml"
			# puts "stdout_str: #{stdout_str}"
			# puts "stderr_str: #{stderr_str}"
			# puts "status: #{status}"
			# puts "status.exitstatus: #{status.exitstatus}"
			cmd = "`mv #{file} #{final_path}`"
			process_cmd(cmd,'stdout')
		
		    return "Success: method completed"
		end

		def set_app_group_ownership(host_path, final_deployer_group)
			cmd = "`chown -R :#{final_deployer_group} #{host_path}`"
			process_cmd(cmd)
		end

		def set_app_permissions(host_path)
			cmd = "`chmod -R 775 #{host_path}`"
			process_cmd(cmd)
		end

		def process_cmd(cmd,stdout=false)
			# puts "IN process_cmd"
			stdout_str, stderr_str, status = Open3.capture3(cmd)
			unless status.exitstatus == 0
				DeployLog.stderr_log.fatal {stderr_str}
			    STDERR.puts Rainbow("ERROR: #{stderr_str} ").red
			    exit 1	
			end

			unless stdout == false
				STDOUT.puts stdout_str
			end
		end
	end
end