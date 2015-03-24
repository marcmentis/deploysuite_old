module Deploysuite
	class RailsProxy
		include CommandlineExecuter

		# def test_from_runner(args)
		# 	args == '/tmp/testapp' ? true : false
		# end

		def bundle
			cmd = "bundle --without development test"
			# process_cmd(cmd,'stdout')
			open3method(cmd, 'out')
		end

		def precompile_assets
			cmd = "RAILS_ENV=production bundle exec rake assets:precompile"
			# process_cmd(cmd,'stdout')
			open3method(cmd, 'out')	
		end

		def load_schema
			cmd = "bundle exec rake db:schema:load RAILS_ENV=production"
			# process_cmd(cmd)
			open3method(cmd, 'out')
		end

		def migrate_db
			cmd = "bundle exec rake db:migrate RAILS_ENV=production"
			# process_cmd(cmd)
			open3method(cmd, 'out')
		end

		def generate_sql_script
			cmd = "bundle exec rake db:schema:to_sql RAILS_ENV=production"
			# process_cmd(cmd)
			open3method(cmd, 'out')
		end

		def rspec_tests
			cmd = "bundle exec rspec spec --color --format documentation"
			# process_cmd(cmd, 'stdout')
			open3method(cmd, 'out')
		end

		def cucumber_tests
			# cmd = bundle exec rake features - PUT GLI CODE INTO APP
			cmd = "bundle exec cucumber"
			open3method(cmd, 'out')
		end

		def clobber_assets
			cmd = "bundle exec rake assets:clobber RAILS_ENV=production"
			open3method(cmd, 'out')
		end
	end
end