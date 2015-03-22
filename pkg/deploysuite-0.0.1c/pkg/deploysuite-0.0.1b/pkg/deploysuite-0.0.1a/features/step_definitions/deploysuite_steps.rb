

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

	runner = Runner.new(rails_proxy: r)
	runner.run_bundle()
end

Then(/^send precompile assets command$/) do
	r = double()
	r.stub(:precompile_assets)

	runner = Runner.new(rails_proxy: r)
	runner.run_precompile_assets()
end

Then(/^send loads db schema command$/) do
	r = double()
	r.stub(:load_schema)

	runner = Runner.new(rails_proxy: r)
	runner.run_load_schema()

end

Then(/^send make first commit command$/) do
	g = double()
	g.stub(:first_commit)

	r = Runner.new(validator: Validator.new, env_values: EnvValues.new, git_proxy: g)
	r.run_first_commit()
end

Then(/^send start application command$/) do
	u = double()
	u.stub(:start_application)

	runner = Runner.new(utils_proxy: u)
	runner.run_start_application()
end

Then(/^send rspec test command$/) do
	r = double()
	r.stub(:rspec_tests)

	runner = Runner.new(rails_proxy: r)
	runner.run_rspec_tests
end

Then(/^send cucumber test command$/) do
	r = double()
	r.stub(:cucumber_tests)

	runner = Runner.new(rails_proxy: r)
	runner.run_cucumber_tests
end

Then(/^send clobber assets command$/) do
	r = double()
	r.stub(:clobber_assets)

	runner = Runner.new(rails_proxy: r)
	runner.run_clobber_assets
end

Then(/^send message to stash local changes$/) do
  g = double()
  g.stub(:stash_local_changes)
  runner = Runner.new(git_proxy: g)
  runner.run_stash_local_changes
end

Then(/^send message to fetch appropriate branch from origin$/) do
  g = double()
  g.stub(:fetch_branch_from_origin)
  v = double()
  v.stub(:get_get_branch)
  # ev = double()
  # ev.stub(:machine_name)
  runner = Runner.new(git_proxy: g, env_values: EnvValues.new, validator: Validator.new)
  runner.run_fetch_branch_from_origin
end
