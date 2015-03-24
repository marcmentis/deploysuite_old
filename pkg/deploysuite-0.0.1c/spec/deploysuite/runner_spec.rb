require "spec_helper"

module Deploysuite
	describe Runner do
		context "Message from Runner successfully sent to:" do
			before(:each) do
				r = Runner.new
				@ans = r.test_message
			end
			it "RailsProxy" do
				rails = @ans[:rails]
				expect(rails).to eq true
			end

			it "UtilsProxy" do
				utils = @ans[:utils]
				expect(utils).to eq true
			end

			it "GitProxy" do
				gprox = @ans[:gprox]
				expect(gprox).to eq true
			end

			it "EnvValues" do
				enval = @ans[:enval]
				expect(enval).to eq true
			end

			it "Validator" do
				validator = @ans[:validator]
				expect(validator).to eq true
			end
		end			
		
	end
end