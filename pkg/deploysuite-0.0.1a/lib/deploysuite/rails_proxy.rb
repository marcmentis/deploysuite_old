module Deploysuite
	class RailsProxy < Proxy

		def bundle
			cmd = "bundle --without development test"
			process_cmd(cmd,'stdout')
	    	# STDOUT.puts stdout_str		
		end

		def precompile_assets
			cmd = "RAILS_ENV=production bundle exec rake assets:precompile"
			process_cmd(cmd,'stdout')
			# STDOUT.puts stdout_str	
		end

		def load_schema
			cmd = "bundle exec rake db:schema:load RAILS_ENV=production"
			process_cmd(cmd)
		end

		def generate_sql_script
			cmd = "bundle exec rake db:schema:to_sql RAILS_ENV=production"
			process_cmd(cmd)
		end


		# def process_cmd(cmd,stdout=false)
		# 	stdout_str, stderr_str, status = Open3.capture3(cmd)
		# 	unless status.exitstatus == 0
		# 		DeployLog.stderr_log.fatal {stderr_str}
		# 	    STDERR.puts Rainbow("ERROR: #{stderr_str} ").red
		# 	    exit 1	
		# 	end

		# 	unless stdout == false
		# 		# STDOUT.puts stdout_str
		# 		output = "#{stdout_str}\n#{stderr_str}"
		#     	STDOUT.puts output
		# 	end
		# end
	end
end