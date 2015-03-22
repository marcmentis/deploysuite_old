

When /^I get help for "([^"]*)"$/ do |app_name|
  @app_name = app_name
  step %(I run `#{app_name} help`)
end

# Add more step definitions here

Given(/^app \/tmp\/test_app does not exist$/) do
  	host_path = "/tmp/test_app" 
	# Check if host_path exist and remove
	if Dir.exists?(host_path)
		`rm -Rf #{host_path}`
	end
end

Given(/^secret_config1 file exists$/) do
  `touch /rails/test_app_enc_application.yml`
end

Then(/^remove app \/tmp\/test_app$/) do
  	host_path = "/tmp/test_app" 
	# Check if host_path exist and remove
	if Dir.exists?(host_path)
		`rm -Rf #{host_path}`
	end
end

Then(/^remove secret_config1 file$/) do
  `rm /rails/test_app_enc_application.yml`
end

Then(/^clone test_app$/) do
 	`touch /tmp/stdout.txt`
  	`git clone -b dev git@github.com:marcmentis/trash1.git /tmp/test_app 2>/tmp/stdout.txt`
  	`rm /tmp/stdout.txt`
end

Given(/^deploysuite started in app root directory$/) do
  #Don't do anything
end

Then(/^send bundle command$/) do
	r = double()
	r.stub(:bundle)
	r.stub(:process_cmd)

	runner = Runner.new(rails_proxy: r)
	runner.run_bundle()
end

Then(/^send precompile assets command$/) do
	r = double()
	r.stub(:precompile_assets)
	r.stub(:process_cmd)

	runner = Runner.new(rails_proxy: r)
	runner.run_precompile_assets()
end

Then(/^send loads db schema command$/) do
	r = double()
	r.stub(:load_schema)
	r.stub(:process_cmd)

	runner = Runner.new(rails_proxy: r)
	runner.run_load_schema()

end

Then(/^send make first commit command$/) do
	g = double()
	g.stub(:first_commit)
	g.stub(:process_cmd)

	r = Runner.new(validator: Validator.new, env_values: EnvValues.new, git_proxy: g)
	r.run_first_commit()
end

Then(/^send start application command$/) do
	u = double()
	u.stub(:start_application)
	u.stub(:process_cmd)

	runner = Runner.new(utils_proxy: u)
	runner.run_start_application()
end

Then(/^send rspec test command$/) do
	r = double()
	r.stub(:rspec_tests)
	r.stub(:process_cmd)

	runner = Runner.new(rails_proxy: r)
	runner.run_rspec_tests
end

Then(/^send cucumber test command$/) do
	r = double()
	r.stub(:cucumber_tests)
	r.stub(:cucumber_cmd)

	runner = Runner.new(rails_proxy: r)
	runner.run_cucumber_tests
end
