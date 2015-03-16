# require 'open3'
require 'rainbow'
module Deploysuite
	class UtilsProxy
		def move_secret_file(file, host_path)
			final_path = "#{host_path}/config/enc_application.yml"
			# cmd = "FileUtils.mv(#{file}, #{host_path})"
			cmd = "`mv #{file} #{final_path}`"
			stdout_str, stderr_str, status = Open3.capture3(cmd)

			# puts "stdout_str: #{stdout_str}"
			# puts "stderr_str: #{stderr_str}"
			# puts "status: #{status}"
			# puts "status.exitstatus: #{status.exitstatus}"

			unless status.exitstatus == 0
				    DeployLog.stderr_log.fatal {stderr_str}
				    STDERR.puts Rainbow("ERROR: #{stderr_str} ").red
				    exit 1	      
		    end
		    return "Success: method completed"
		end

		def set_app_group_ownership(host_path, final_deployer_group)
			cmd = "`chown -R :#{final_deployer_group} #{host_path}`"
			stdout_str, stderr_str, status = Open3.capture3(cmd)

			unless status.exitstatus == 0
				    DeployLog.stderr_log.fatal {stderr_str}
				    STDERR.puts Rainbow("ERROR: #{stderr_str} ").red
				    exit 1	      
		    end
		end

		def set_app_permissions(host_path)
			cmd = "`chmod -R 775 #{host_path}`"
			stdout_str, stderr_str, status = Open3.capture3(cmd)

			unless status.exitstatus == 0
				    DeployLog.stderr_log.fatal {stderr_str}
				    STDERR.puts Rainbow("ERROR: #{stderr_str} ").red
				    exit 1	      
		    end
		end
	end
end