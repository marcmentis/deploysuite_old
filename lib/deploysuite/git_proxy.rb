module Deploysuite
	class GitProxy
		def clone(git_branch, repo, host_path)
						
		    command = "git clone -b #{git_branch} #{repo} #{host_path}"
		    stdout_str, stderr_str, status = Open3.capture3(command)
		    
		    # STDOUT.puts stdout_str
		    # puts "stdout_str: #{stdout_str}"
		    # puts "stderr_str: #{stderr_str}"
		    # puts "status: #{status}"
		    # puts "status.exitstatus: #{status.exitstatus}"

		    unless status.exitstatus == 0
				    puts "There was an error running '#{command}'"
				    # DeployLog.stderr_log.fatal {stderr_str}
				    STDERR.puts stderr_str
				    exit 1	      
		    end
		     
		    # If you have any errors, just raise them
		    # raise "that command made no sense"

		    # GitHub comments using STDERR with existatus of 0
		    output = "#{stdout_str}\n#{stderr_str}"
		    STDOUT.puts output
			
		end
	end
end