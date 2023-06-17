platform :ios do

	desc "Signing process initiated.. 🔐"
	desc "Fetching certificates and provisioning profiles.."
	lane :sign_ad_hoc do

		get_certificates(
		 	keychain_password: ENV["KEYCHAIN_PASSWORD"],
		 	output_path: ENV["CERT_PATH"]
		)

		sigh(
		 	adhoc: true,
		 	force: true,
		 	app_identifier: ENV["DEV_APP_IDENTIFIER"],
		 	filename: ENV["AD_HOC_SIGH_NAME"],
		 	output_path: ENV["SIGH_OUTPUT_PATH"]
		)
	end
end