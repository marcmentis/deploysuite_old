#!/usr/bin/env ruby
require 'socket'
require 'open3'
require 'logger'
require 'rainbow'



		def process_cmd(cmd,stdout=false)
			stdout_str, stderr_str, status = Open3.capture3(cmd)

			puts "IN process_cmd"
			puts "stdout_str: #{stdout_str}"
		    puts "stderr_str: #{stderr_str}"
		    puts "status: #{status}"
		    puts "status.exitstatus: #{status.exitstatus}"
			
			unless status.exitstatus == 0
				DeployLog.stderr_log.fatal {stderr_str}
			    STDERR.puts Rainbow("ERROR: #{stderr_str} ").red
			    exit 1	
			end

			unless stdout == false
				STDOUT.puts stdout_str
			end
		end

		def first_commit
			cmd = "git add ."
			process_cmd(cmd,'stdout')
			# STDOUT.puts stdout_str	

			cmd = "git commit -m 'First Commit'"
			process_cmd(cmd,'stdout')
			# STDOUT.puts stdout_str				
		end

		def precompile_assets
			cmd = "RAILS_ENV=production bundle exec rake assets:precompile"
			process_cmd(cmd,'stdout')
			# STDOUT.puts stdout_str	
		end

precompile_assets