module Deploysuite
	class RailsProxy
		def bundle(host_path)
				puts "pwd:  #{`pwd`}"

				cmd = "bundle"
				stdout_str, stderr_str, status = Open3.capture3(cmd)
				puts "bundle run"
				puts "pwd: #{`pwd`}"

				 # STDOUT.puts stdout_str
			    puts "stdout_str: #{stdout_str}"
			    # puts "stderr_str: #{stderr_str}"
			    puts "status: #{status}"
			    puts "status.exitstatus: #{status.exitstatus}"

			     unless status.exitstatus == 0
				    puts "There was an error running '#{cmd}'"
				    DeployLog.stderr_log.fatal {stderr_str}
				    # STDERR.puts stderr_str
				    STDERR.puts Rainbow("ERROR: #{stderr_str} ").red
				    exit 1	      
		    	end

			
		end
	end
end