require 'spec_helper'

module Deploysuite
	describe UtilsProxy do
		it "moves secret file to app/config folder" do
			u = UtilsProxy.new
			`touch /tmp/testfile.txt`
			# `mkdir /tmp/config`
			file = "/tmp/testfile.txt"
			host_path = "/tmp"
			result = u.move_secret_file(file, host_path)
			# `rm -Rf /tmp/config`
		end
		
	end
end