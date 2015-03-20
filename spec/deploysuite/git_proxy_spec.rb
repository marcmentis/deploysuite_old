require "spec_helper"

module Deploysuite
	describe Runner do
		describe GitProxy do 
			context "Send message to:"  do
				it "clones the appropriate branch" do
					g = double()
					g.stub(:clone_branch)
					g.stub(:process_cmd)

					r = Runner.new(validator: Validator.new, env_values: EnvValues.new, git_proxy: g)
					r.run_clone_branch('stub-repo', 'stub-host_path')
					# expect(result).to include(true)
				end
				it "performs first commit" do
					g = double()
					g.stub(:first_commit)
					g.stub(:process_cmd)

					r = Runner.new(validator: Validator.new, env_values: EnvValues.new, git_proxy: g)
					r.run_first_commit()
				end
			end	
		end
		
	end
end
