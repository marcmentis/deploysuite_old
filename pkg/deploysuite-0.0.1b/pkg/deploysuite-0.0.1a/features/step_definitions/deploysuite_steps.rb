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
