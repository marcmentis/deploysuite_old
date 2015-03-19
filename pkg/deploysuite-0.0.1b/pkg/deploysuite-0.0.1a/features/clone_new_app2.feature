Feature: deployer clones new app - part 2

	To automate finishing the setup of a newly cloned repo branch, a deployer will 'CD' INTO THE ROOT DIRECTORY of the newly cloned branch and run deploysuites' 'clone_new_app2' command. The deployer must belong to the 'final_deploy_group' on the server. Appropriate 'bundler', 'rails', 'rake', 'git', and 'bash' commands will be used to install gems (bundler), precompile assets, setup database [optional], commit the local git repo, start the host application, and run app tests.

	The 'clone_new_app2' command takes the 'host_path' to the new app as a global flag.

	Usage example: $ deploysuite --host_path=/path/to/host clone_new_app2

	The 'clone_new_app' command will perform the following functions:
		1. Run the 'bundle' command for the production environment
		2. Precompile Assets for the app
		3. Setup database (optional):
			Command flag controls if db setup should occur, and if so whether database should be created or just SQL code generated 
			(i) For Dev - run rake 'db:shcema:load' command
			(ii) For QA and Prod - Generate the SQL code for DB creation
		4. Make first commit to local git repo on server
		5. Start Application
		6. Run Behavioral and unit test