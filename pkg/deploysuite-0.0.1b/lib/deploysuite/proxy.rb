module Deploysuite
	class Proxy
		def process_cmd(cmd,stdout=false)
			stdout_str, stderr_str, status = Open3.capture3(cmd)
			unless status.exitstatus == 0
				DeployLog.stderr_log.fatal {stderr_str}
			    STDERR.puts Rainbow("ERROR: #{stderr_str} ").red
			    exit 1	
			end

			unless stdout == false
				# STDOUT.puts stdout_str
				output = "#{stdout_str}\n#{stderr_str}"
		    	STDOUT.puts output
			end
		end
	end
end