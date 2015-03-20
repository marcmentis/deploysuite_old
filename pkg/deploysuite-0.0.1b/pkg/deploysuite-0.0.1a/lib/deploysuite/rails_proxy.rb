module Deploysuite
	class RailsProxy < Proxy

		def bundle
			cmd = "bundle --without development test"
			process_cmd(cmd,'stdout')	
		end

		def precompile_assets
			cmd = "RAILS_ENV=production bundle exec rake assets:precompile"
			process_cmd(cmd,'stdout')	
		end

		def load_schema
			cmd = "bundle exec rake db:schema:load RAILS_ENV=production"
			process_cmd(cmd)
		end

		def generate_sql_script
			cmd = "bundle exec rake db:schema:to_sql RAILS_ENV=production"
			process_cmd(cmd)
		end

		def rspec_tests
			cmd = "bundle exec rspec spec"
			process_cmd(cmd, 'stdout')
		end

		def cucumber_tests
			cmd = "bundle exec cucumber"
			process_cmd(cmd, 'stdout')
		end
	end
end