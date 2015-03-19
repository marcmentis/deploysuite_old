module Deploysuite
	class UtilsProxy < Proxy
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
		end

		def move_secret_file(file, host_path)
			final_path = "#{host_path}/config/enc_application.yml"
			cmd = "mv #{file} #{final_path}"
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
	end
end