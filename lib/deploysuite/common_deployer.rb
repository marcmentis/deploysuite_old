module CommonDeployer
	def clone_new_app1(args={})
		r = Runner.new(validator: Validator.new, env_values: EnvValues.new, git_proxy: GitProxy.new, utils_proxy: UtilsProxy.new)

		r.run_in_final_deployer_group?(args[:host_path])
		r.run_path_to_host_legal?(args[:host_path])
		r.run_app_not_exist?(args[:host_path])
		r.run_repo_exists?(args[:repo])
		r.run_secret_config1?(args[:host_path])
		r.run_clone_branch(args[:repo], args[:host_path])
		r.run_move_secret_file(args[:host_path])
		r.run_set_app_privileges_ownership(args[:host_path])
	end
end