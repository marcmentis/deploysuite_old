
module Deploysuite
	class GitProxy 
		include CommandlineExecuter
		
		def clone_branch(git_branch, repo, host_path)						
		    cmd = "git clone -b #{git_branch} #{repo} #{host_path}"
		    # process_cmd(cmd)
		    open3method(cmd, 'out')		
		end

		def first_commit
			cmd = "git add ."
			# process_cmd(cmd)
			open3method(cmd, 'out')

			cmd = "git commit -m 'First Commit'"
			# process_cmd(cmd)
			open3method(cmd, 'out')				
		end
	end
end