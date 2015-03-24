module Deploysuite
	class DevDeployer
		include CommonDeployer

		def clone_app_db_functions
			r.run_load_schema if args[:db]
		end
		def update_app_db_functions
			r.run_migrate_db
		end
		
	end
end