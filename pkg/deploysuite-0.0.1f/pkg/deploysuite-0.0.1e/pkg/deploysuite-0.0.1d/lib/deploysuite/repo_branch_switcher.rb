module Deploysuite
	class RepoBranchSwitcher
		attr_reader :v, :ev, :git_branch

		def initialize
			@v = Validator.new()
			@ev = EnvValues.new() 
		    @git_branch = get_git_branch
		end
		

		def get_git_branch
			git_branch = v.get_git_branch(ev.machine_name)
		end

		def send(switch_info={})
			args = switch_info[:args]
			command = switch_info[:command]
			

			case git_branch
			    when "dev"
			    	# puts "In dev"
			    	dev = DevDeployer.new()
					whole_message = "dev.#{command}(#{args})"
					eval(whole_message)
			    when "qa"
			    	# puts "In qa"
			    	qa = QaDeployer.new()
			    	whole_message = "qa.#{command}(#{args})"
					eval(whole_message)
			    when "master"
			    	# puts "In prod"
			    	prod = ProdDeployer.new()
			    	whole_message = "prod.#{command}(#{args})"
					eval(whole_message)
			    else
			      STDERR.puts Rainbow("ERROR: This machine '#{ev.machine_name}' does NOT have permission to run this app.").red
			      exit 1
		    end		
		end
		

	
		
	end
end