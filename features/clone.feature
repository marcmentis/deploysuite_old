Feature: deployer clones new app

	To automate (i) cloning the correct application branch onto the appropriate server, and (ii) verification of the user, application and file system, a deployer will run deploysuites' 'clone' command. The deployer must belong to the 'deployer' group on the server. The version controll system 'git' will be used to clone the repo branch onto the server. The 'dev' branch will be cloned onto DEV servers, 'qa' branch onto QA servers and 'master' branch onto 'PROD' servers. 

	To perform these functions automatically the 'clone' command takes the 'host_path' to the new app as a global switch option, and the repo URL as its argument. 

	For example: $ deploysuite --host_path=/path/to/host clone repo/url


	Scenario: user is member of 'deployer' group on server

	Scenario: path to app is legal

	Scenario: app does not exist on server

	Scenario: get appropriate branch name for server



