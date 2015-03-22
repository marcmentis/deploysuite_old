#!/usr/bin/env ruby
require 'socket'
require 'open3'
require 'logger'
require 'rainbow'



		# def process_cmd(cmd,stdout=false)
			# 	stdout_str, stderr_str, status = Open3.capture3(cmd)

			# 	puts "IN process_cmd"
			# 	puts "stdout_str: #{stdout_str}"
			#     puts "stderr_str: #{stderr_str}"
			#     puts "status: #{status}"
			#     puts "status.exitstatus: #{status.exitstatus}"
				
			# 	unless status.exitstatus == 0
			# 		DeployLog.stderr_log.fatal {stderr_str}
			# 	    STDERR.puts Rainbow("ERROR: #{stderr_str} ").red
			# 	    exit 1	
			# 	end

			# 	unless stdout == false
			# 		STDOUT.puts stdout_str
			# 	end
			# end

	def open3method(cmd, out=false)

		stdout_str, stderr_str, status = Open3.capture3(cmd)
		# unless status.exitstatus == 0
		# 	DeployLog.stderr_log.fatal {stderr_str}
		#     $stderr.puts Rainbow("ERROR: #{stderr_str} ").red
		#     exit 1	
		# end

		unless out == false
			# STDOUT.puts stdout_str
			output = "#{stdout_str}\n#{stderr_str}"
	    	$stdout.puts output
		end	

		return {stdout: stdout_str, stderr: stderr_str, st: status, exit: status.exitstatus}	
	end

		def first_commit
			cmd = "git add ."
			# process_cmd(cmd,'stdout')
			open3method(cmd, 'out')	

			cmd = "git commit -m 'First Commit'"
			# process_cmd(cmd,'stdout')
			open3method(cmd, 'out')				
		end

		def precompile_assets
			cmd = "RAILS_ENV=production bundle exec rake assets:precompile"
			# process_cmd(cmd,'stdout')
			open3method(cmd, 'out')	
		end

		def rspec_tests
			cmd = "bundle exec rspec spec"
			# process_cmd(cmd,'stdout')
			open3method(cmd, 'out')
		end

		def fail_with_invalid_command
			cmd = "ls --rubbish"
			r=open3method(cmd)
			puts "stdout_str: #{r[:stdout]}"
		    puts "stderr_str: #{r[:stderr]}"
		    puts "status: #{r[:status]}"
		    puts "status.exitstatus: #{r[:exit]}"
		end

		def clobber_assets
			cmd = "bundle exec rake assets:clobber RAILS_ENV=production"
			r=open3method(cmd, 'out')
			puts "stdout_str: #{r[:stdout]}"
		    puts "stderr_str: #{r[:stderr]}"
		    puts "status: #{r[:status]}"
		    puts "status.exitstatus: #{r[:exit]}"
		end

		def stash_local_changes
			cmd = "git stash"
			r= open3method(cmd)	
			puts "stdout_str: #{r[:stdout]}"
		    puts "stderr_str: #{r[:stderr]}"
		    puts "status: #{r[:status]}"
		    puts "status.exitstatus: #{r[:exit]}"	
		end

		def fetch_branch_from_origin(git_branch)
			cmd = "git fetch -v origin #{git_branch}:refs/remotes/origin/#{git_branch}"
			r= open3method(cmd, 'out')	
			puts "stdout_str: #{r[:stdout]}"
		    puts "stderr_str: #{r[:stderr]}"
		    puts "status: #{r[:status]}"
		    puts "status.exitstatus: #{r[:exit]}"		
		end




# rspec_tests
# fail_with_invalid_command
# clobber_assets
# stash_local_changes
fetch_branch_from_origin('dev')



