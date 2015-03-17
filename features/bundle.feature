Feature: deployer runs the 'bundle' command for an app

	To automate running the bundle command for an application, a deployer will run deploysuites' 'bundle' command.

	This is a 'plumbing' command. It is part of the 'clone_new_app' and 'update_app' commands. No validations are performed, i.e., to check the deployer, or that the app exists etc.

	The 'bundle' command takes the 'host_path' (path to app) as a global flag.

	Usage example: $ deploysuite --host_path=/path/to/host bundle

	Scenario: 'bundle' command runs successfully
		Given app /tmp/test_app does not exist
		Then clone test_app
		When I successfully run `deploysuite --host_path=/tmp/test_app bundle`
		Then the stdout should contain "Success:"
		#Then remove app /tmp/test_app