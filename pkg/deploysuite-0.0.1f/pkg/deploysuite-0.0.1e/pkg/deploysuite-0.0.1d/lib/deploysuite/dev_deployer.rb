module Deploysuite
	class DevDeployer
		include CommonDeployer

		def update_app_db_functions
			r.run_migrate_db
		end
		
	end
end