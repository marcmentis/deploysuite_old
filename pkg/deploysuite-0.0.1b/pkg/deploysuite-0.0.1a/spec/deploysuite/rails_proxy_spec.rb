require "spec_helper"

module Deploysuite
	describe Runner do
		describe RailsProxy do 
			context "Send message to:" do
				it "performs bundle command without development test" do
					r = double()
					r.stub(:bundle)
					r.stub(:process_cmd)

					runner = Runner.new(rails_proxy: r)
					runner.run_bundle()
				end

				it "precompiles assets in production environment" do
					r = double()
					r.stub(:precompile_assets)
					r.stub(:process_cmd)

					runner = Runner.new(rails_proxy: r)
					runner.run_precompile_assets()
				end

				it "loads schema" do
					r = double()
					r.stub(:load_schema)
					r.stub(:process_cmd)

					runner = Runner.new(rails_proxy: r)
					runner.run_load_schema()
				end

				it "generates SQL script" do
					r = double()
					r.stub(:generate_sql_script)
					r.stub(:process_cmd)

					runner = Runner.new(rails_proxy: r)
					runner.run_generate_sql_script()
				end

				it "runs rspec tests" do
					r = double()
					r.stub(:rspec_tests)
					r.stub(:process_cmd)

					runner = Runner.new(rails_proxy: r)
					runner.run_rspec_tests
				end

				it "runs cucumber tests" do
					r = double()
					r.stub(:cucumber_tests)
					r.stub(:cucumber_cmd)

					runner = Runner.new(rails_proxy: r)
					runner.run_cucumber_tests
				end
			end

		end
		
	end
end