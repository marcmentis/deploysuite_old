Feature: deployer clones new app

	To automate (i) cloning the correct application branch onto the appropriate server, and (ii) verification of the user, application and file system, a deployer will run deploysuites' 'clone_new_app' command. The deployer must belong to the 'deployer' group on the server. The version controll system 'git' will be used to clone the appropriate repo branch onto the server. The 'dev' branch will be cloned onto DEV servers, 'qa' branch onto QA servers and 'master' branch onto 'PROD' servers. 

	The 'clone_new_app' command takes the 'host_path' to the new app as a global switch option, and the repo URL as its argument. It will automatically verify: (i)The user belongs to the 'deployers' group on the server, (ii) the path to the host is legal, (iii) the app does not exist at the given host_path, (iv) the repo exist and the deployer has appropriate privileges.

	Usage example: $ deploysuite --host_path=/path/to/host clone_new_app repo/url


	Scenario: 'clone_new_app' command runs successfully
		Given app /tmp/test_app does not exist
		When I successfully run `deploysuite --host_path=/tmp/test_app clone_new_app -r 'git@github.com:marcmentis/trash1.git'` 
		Then the stdout should contain "'Clone_new_app' command successfully run"
		Then remove app /tmp/test_app