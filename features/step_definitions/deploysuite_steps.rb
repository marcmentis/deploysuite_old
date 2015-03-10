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
Then(/^remove app \/tmp\/test_app$/) do
  	host_path = "/tmp/test_app" 
	# Check if host_path exist and remove
	if Dir.exists?(host_path)
		`rm -Rf #{host_path}`
	end
end
