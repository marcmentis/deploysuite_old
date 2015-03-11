require 'spec_helper'

module Deploysuite
	describe Validator do
		it "User belongs to given group" do
			v = Validator.new
			user = 'marcmentis'
			user_group = "staff _developer some_other_group deployer"
			required_group = 'deployers'

			user = v.valid_user?(user, user_group, required_group)
			expect(user).to eq true
		end
		
	end
end