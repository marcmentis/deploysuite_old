module Deploysuite
	class EnvValues
		# attr_accessor :USER
		attr_reader :user, :user_groups, :logged_time, :machine_name

		def initialize()
			@user = ENV["USER"]
			@user_groups = `groups`
			@logged_time = Time.now.strftime("Logged on %m/%d/%Y at: %I:%M%P")
			@machine_name = Socket.gethostname.downcase
		end
			
		def get_git_branch
			case @machine_name
				when "omhrord1.omh.ny.gov", "marcs-mbp", "u14"
					@git_branch = 'dev'
				when "omhrorq1.omh.ny.gov"
					@git_branch = 'qa'
				when "omhrorp1.omh.ny.gov"
					@git_branch = 'prod'
				else
					STDERR.puts "This machine does NOT HAVE permission to run this script.\
					 						\n\tHostname is: '#{@machine_name}' "
					exit 2
			end
		end
	end
end