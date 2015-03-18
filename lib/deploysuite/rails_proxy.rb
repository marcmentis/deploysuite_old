module Deploysuite
	class RailsProxy
		def check_pwd(host_path)
			pwd = `pwd`.chomp
			puts "pwd: #{pwd}"
			unless pwd == host_path
				DeployLog.stderr_log.fatal {"ERROR: Need to run 'deploysuite' from within app root: '#{host_path}'"}
				STDERR.puts Rainbow("ERROR: Need to run 'deploysuite' from within app root: '#{host_path}'").red
				exit 1
			end
		end

		def bundle
			cmd = "bundle --without development test"
			stdout_str, stderr_str, status = Open3.capture3(cmd)

		    unless status.exitstatus == 0
			    # puts "There was an error running '#{cmd}'"
			    DeployLog.stderr_log.fatal {stderr_str}
			    STDERR.puts Rainbow("ERROR: #{stderr_str} ").red
			    exit 1	      
	    	end

	    	STDOUT.puts stdout_str		
		end

		def precompile_assets
			cmd = "RAILS_ENV=production bundle exec rake assets:precompile"
			stdout_str, stderr_str, status = Open3.capture3(cmd)
			unless status.exitstatus == 0
				DeployLog.stderr_log.fatal {stderr_str}
			    STDERR.puts Rainbow("ERROR: #{stderr_str} ").red
			    exit 1	
			end
			STDOUT.puts stdout_str	
		end

		def first_commit
			cmd = "git add ."
			stdout_str, stderr_str, status = Open3.capture3(cmd)
			unless status.exitstatus == 0
				DeployLog.stderr_log.fatal {stderr_str}
			    STDERR.puts Rainbow("ERROR: #{stderr_str} ").red
			    exit 1	
			end
			STDOUT.puts stdout_str	

			cmd = "git commit -m 'First Commit'"
			stdout_str, stderr_str, status = Open3.capture3(cmd)
			unless status.exitstatus == 0
				DeployLog.stderr_log.fatal {stderr_str}
			    STDERR.puts Rainbow("ERROR: #{stderr_str} ").red
			    exit 1	
			end
			STDOUT.puts stdout_str				
		end

		def start_application
			cmd = "touch tmp/restart.txt"
			stdout_str, stderr_str, status = Open3.capture3(cmd)
			unless status.exitstatus == 0
				DeployLog.stderr_log.fatal {stderr_str}
			    STDERR.puts Rainbow("ERROR: #{stderr_str} ").red
			    exit 1	
			end
			STDOUT.puts stdout_str	
		end

		

	end
end