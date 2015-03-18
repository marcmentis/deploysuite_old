module Deploysuite
	class RailsProxy
		def bundle(host_path)
				pwd = `pwd`
				if pwd == host_path
					cmd = "bundle"
					stdout_str, stderr_str, status = Open3.capture3(cmd)

				     unless status.exitstatus == 0
					    puts "There was an error running '#{cmd}'"
					    DeployLog.stderr_log.fatal {stderr_str}
					    # STDERR.puts stderr_str
					    STDERR.puts Rainbow("ERROR: #{stderr_str} ").red
					    exit 1	      
			    	end

			    	STDOUT.puts stdout_str
				else
					STDERR.puts Rainbow("ERROR: Need to run 'deploysuite' from within '#{host_path}'").red
					exit 1
				end
				

			
		end
# cd /tmp/test_app && RAILS_ENV=production bundle exec rake assets:precompile 
	end
end