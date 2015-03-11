require 'socket'  # needed for RSpec

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
			
	end
end