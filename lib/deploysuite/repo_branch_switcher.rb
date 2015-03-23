module Deploysuite
	class RepoBranchSwitcher
		attr_reader :v, :ev, :git_branch
		def initialize
			# @v = args[:validator] 
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
			

			case @git_branch
			    when "dev"
			    	puts "In dev"
					dev = DevDeployer.new()
					whole_message = "dev.#{command}(args)"
					eval(whole_message)
					# dev.wrong_function(args)
			    when "qa"
			    	qa = QaDeveloper.new()
			    	whole = "qa.#{command}(args)"
					eval(whole_message)
			    when "prod"
			    	whole = "prod.#{command}(args)"
					eval(whole_message)
			    else
			      STDERR.puts Rainbow("ERROR: This machine '#{ev.machine_name}' does NOT have permission to run this app.").red
			      exit 1
		    end		
		end
		

	
		
	end
end