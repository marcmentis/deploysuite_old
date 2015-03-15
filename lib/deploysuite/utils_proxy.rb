
module Deploysuite
	class UtilsProxy
		def move_secret_file(file, host_path)
			final_path = "#{host_path}/config/enc_application.yml"
			# cmd = "FileUtils.mv(#{file}, #{host_path})"
			cmd = "`mv #{file} #{final_path}`"
			stdout_str, stderr_str, status = Open3.capture3(cmd)
			puts "stdout_str: #{stdout_str}"
			puts "stderr_str: #{stderr_str}"
			puts "status: #{status}"
			puts "status.exitstatus: #{status.exitstatus}"
		end
	end
end