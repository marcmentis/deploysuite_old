Feature: deployer updates existing app

	To automate updating an existing application, a deployer will 'CD' INTO THE ROOT DIRECTORY of the newly cloned branch and run deploysuites' 'update_app' command. The deployer must belong to the 'final_deploy_group' on the server. Appropriate 'bundler', 'rails', 'rake', 'git', and 'bash' commands will be used to perform all steps necessary for updating the app, changing db tables/ creating SQL script [optional] and running tests [optional]

	The 'update_app' command has one required global flag [--host_path], one required flag [-m], and three optional local switches [--db], [--rspec], [--cucumber]

	Usage example: $ deploysuite --host_path=/path/to/host update_app -m "Add function" [--db] [--rspec] [--cucumber]

	The 'update_app' command will perform the following functions:
		1. Remove (clobber) existing precompiled assets
		2. Stash any local changes
		3. Fetch the appropriate branch from the app (origin repo)
		4. Merge the fetched branch with the appropriate local branch
		5. Update gems with 'bundle' command 
		6. Precompile assets 
		7. Make changes to db tables (DEV server)/ Create SQL script of changes (QA, PROD servers) [optional]
		8. Restart app
		9. Set group privileges
		10. Run RSpec unit tests [optional]
		11. Run Cucumber behavioral tests [optional]
	
	Scenario: 'update_app' command functions
		Given deploysuite started in app root directory
		Then send message to clobber assets
		Then send message to stash local changes 
		Then send message to fetch appropriate branch from origin
		Then send message to merge fetched branch with appropriate local branch
		Then send message to update gems (bundle)
		Then send message to precompile assets

		Then send message to start application
		
		Then send message to run rspec tests
		Then send message to run cucumber tests