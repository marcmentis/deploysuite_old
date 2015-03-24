module CommonDeployer
	attr_reader :r

	def initialize
		# @r = Runner.new(rails_proxy: RailsProxy.new, validator: Validator.new, env_values: EnvValues.new, git_proxy: GitProxy.new, utils_proxy: UtilsProxy.new)
		@r = Runner.new()
	end

	def clone_new_app1(args={})
		r.run_in_final_deployer_group?(args[:host_path])
		r.run_path_to_host_legal?(args[:host_path])
		r.run_app_not_exist?(args[:host_path])
		r.run_repo_exists?(args[:repo])
		r.run_secret_config1?(args[:host_path])
		r.run_clone_branch(args[:repo], args[:host_path])
		r.run_move_secret_file(args[:host_path])
		r.run_set_app_privileges_ownership(args[:host_path])
	end

	def test_method(args={})
		args[:host_path] == "/tmp/testapp" ? true : false

	end

	def clone_new_app2(args={})
		r.run_check_pwd(args[:host_path])
	    r.run_bundle
	    r.run_precompile_assets
	    r.run_load_schema if args[:db]
	    r.run_first_commit
	    r.run_start_application
	    r.run_set_app_privileges_ownership(args[:host_path])
	    r.run_rspec_tests if args[:rspec]
	    r.run_cucumber_tests if args[:cucumber]
		
	end

	def update_app(args={})	
		# # *** If secret_config exisits move it to app	
	    r.run_check_pwd(args[:host_path])
	    r.run_clobber_assets
	    r.run_stash_local_changes
	    r.run_fetch_branch_from_origin
	    r.run_merge_fetched_branch(args[:message])
	    r.run_bundle
	    r.run_precompile_assets
	    # # DB HOOK
	    	update_app_db_functions()	
	    r.run_start_application
	    # *** put privilege change here
	    r.run_rspec_tests if args[:rspec]
	    r.run_cucumber_tests if args[:cucumber]	
	end

	def rspec(args={})
		r.run_check_pwd(args[:host_path])
	    r.run_rspec_tests
	end

	def cucumber(args={})
		r.run_check_pwd(args[:host_path])
    	r.run_cucumber_tests
	end

	def bundle(args={})
		r.run_check_pwd(args[:host_path])
		r.run_bundle
	end

	def clone_branch(args={})
		r.run_clone_branch(args[:repo], args[:host_path])
	end

	def update_app_db_functions
		# HOOK doesn't do anything from common_deployer
	end
end