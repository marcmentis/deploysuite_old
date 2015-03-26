module Deploysuite
	class QaDeployer
		include CommonDeployer
		
		def update_app_db_functions
			r.run_generate_sql_script
		end
	end
end