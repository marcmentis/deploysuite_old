
module Deploysuite
	class GitProxy < Proxy
		def clone_branch(git_branch, repo, host_path)						
		    cmd = "git clone -b #{git_branch} #{repo} #{host_path}"
		    process_cmd(cmd,'stdout')		
		end

		def first_commit
			cmd = "git add ."
			process_cmd(cmd,'stdout')

			cmd = "git commit -m 'First Commit'"
			process_cmd(cmd,'stdout')				
		end
	end
end