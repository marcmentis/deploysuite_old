require 'spec_helper'

module Deploysuite
	describe Validator do
		it "User belongs to given group, expect true" do
			v = Validator.new
			user = 'marcmentis'
			user_group = "staff _developer some_other_group deployer"
			required_group = 'deployer'

			result = v.valid_user?(user, user_group, required_group)
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
			v = Validator.new
			repo = "git@github.com:marcmentis/trash1.git"
			result = v.repo_exists?(repo)
			expect(result).to eq true
		end
		
	end
end