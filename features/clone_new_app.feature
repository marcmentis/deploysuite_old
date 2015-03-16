Feature: deployer clones new app

	To automate cloning the correct application branch onto the appropriate server a deployer will run deploysuites' 'clone_new_app' command. The deployer must belong to the 'deployer' group on the server. The version controll system 'git' will be used to clone the appropriate repo branch into the server. The 'dev' branch will be cloned into DEV servers, 'qa' branch into QA servers and 'master' branch into 'PROD' servers. Every step will be logged either for errors (/rails/log/err_log.txt) or auditing (/rails/log/audit_log.txt).

	The 'clone_new_app' command takes the 'host_path' to the new app as a global flag, and the repo URL as a command flag. 

	Usage example: $ deploysuite --host_path=/path/to/host clone_new_app repo/url

	The 'clone_new_app' command will perform the following functions:
		1. Verification:(i)The user belongs to the 'railsdep' group on the server, (ii) the path to the host is legal, (iii) the app does not exist at the given host_path, (iv) the repo exist and the deployer has appropriate privileges, (v) the secret '<appname>_enc_application.yml' file exists. 
		2. Clone the appropriate repo-branch into the server
		3. Move the secret config file from '/rails/<appname>_enc_application.yml' to /host/path/config/enc_application.yml.
		4. Change the group/privilege assignmets for all the app files
		5. Run the 'bundle' command for the production environment
		6. Precompile Assets for the app
		7. Setup database (optional):
			Command flag controls if db setup should occur, and if so whether database should be created or just SQL code generated 
			(i) For Dev - run rake 'db:shcema:load' command
			(ii) For QA and Prod - Generate the SQL code for DB creation
		8. Make first commit to local git repo on server
		9. Start Application
		10. Run Behavioral and unit test

	


	Scenario: 'clone_new_app' command runs successfully
		Given app /tmp/test_app does not exist
		And secret_config1 file exists
		When I successfully run `deploysuite --host_path=/tmp/test_app clone_new_app -r 'git@github.com:marcmentis/trash1.git'` 
		Then the stdout should contain "Success: 'Clone_new_app' command completed without error"
		Then remove app /tmp/test_app
		And remove secret_config1 file