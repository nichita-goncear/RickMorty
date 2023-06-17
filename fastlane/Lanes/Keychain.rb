platform :ios do

	desc "Keychain update initiated.. 🔑🗄️"
	desc "Deleting previous keychain and creating a new one.."
	lane :update_keychain do

		delete_keychain(
    		name: ENV["KEYCHAIN_NAME"]
  		) if File.exist? File.expand_path("#{ENV["KEYCHAIN_LIBRARY_PATH"]}/#{ENV["KEYCHAIN_NAME"]}-db")

		create_keychain({
    		name: ENV["KEYCHAIN_NAME"],
    		password: ENV["KEYCHAIN_PASSWORD"],
    		unlock: true
  		})
	end
end