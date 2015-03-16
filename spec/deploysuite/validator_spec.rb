require 'spec_helper'

module Deploysuite
	describe Validator do
		# it "User belongs to given group, expect true" do
		# 	v = Validator.new
		# 	user = 'marcmentis'
		# 	user_group = "staff _developer some_other_group deployer"
		# 	required_group = 'deployer'

		# 	result = v.valid_user?(user, user_group, required_group)
		# 	expect(result).to eq true
		# end
		it "Deployer belongs to final_deployer_group, expect true" do
			v = Validator.new
			user = 'testuser'
			user_group = "railsdep omhdep omh_pilg_dep oasasdep"
			host_path = "/rails/omh/testapp"

			result = v.in_final_deployer_group?(user, user_group, host_path)
			expect(result).to eq true
		end
		it "Path to host legal, expect true" do
			v = Validator.new
			host_path = "/rails/omh/app1"
			result = v.path_to_host_legal?(host_path)
			expect(result).to eq true
		end
		it "Clone requres app not exist, expect true" do
			if Dir.exists?("/tmp/xyz")
				`rm -Rf /tmp/xyz`
			end
			v = Validator.new
			host_path = "/tmp/xyz"
			result = v.app_not_exist?(host_path)
			expect(result).to eq true
		end
		it "Repo exists and user has rights, expect true" do
			pending("stub the command to github")
			# v = Validator.new
			# repo = "?"
			# result = v.repo_exists?(repo)
			# expect(result).to eq false
		end
		it "Secret Config file exists, expect true" do
			`touch /rails/testapp_enc_application.yml`
			v = Validator.new
			host_path = "/rails/testapp"
			result = v.secret_config1?(host_path)
			`rm /rails/testapp_enc_application.yml`
			expect(result).to eq true
		end
		it "gets final_deployer_group, expect omhdep" do
			v = Validator.new
			host_path = "/rails/omh/testapp"
			result = v.get_final_deployer_group(host_path)
			expect(result).to eq "omhdep"
		end

		
	end
end