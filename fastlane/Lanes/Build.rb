platform :ios do

	desc "Initiate build process(development).. 🛠️" 
  	lane :build_dev do

  		cocoapods(use_bundle_exec: false)

	  	args = {  
	  		scheme: ENV["DEV_SCHEME"],
	        clean: ENV["CLEAN_BUILD"],
	        export_method: ENV["AD_HOC_EXPORT_METHOD"],
	        configuration: ENV["DEV_BUILD_CONFIG"],  
	        include_bitcode: false,
	        export_options: (
	    	{
	        	compileBitcode: false,
	        	provisioningProfiles: {
			    	ENV["DEV_APP_IDENTIFIER"] => ENV["AD_HOC_SIGH_NAME"]
    			}
	        }),
	        codesigning_identity: ENV["CERT_SIGN_IDENTITY_DISTRIBUTION"],
	        output_directory: ENV["OUTPUT_IPA_PATH"],
	        archive_path: ENV["OUTPUT_ARCHIVE_PATH_FULL"],
	        output_name: ENV["OUTPUT_IPA_NAME"]
	    }

		if ENV["WORKSPACE"]
	        args[:workspace] = ENV["WORKSPACE"]
	    else
	        args[:project] = ENV["PROJECT"]
	    end

	    update_code_signing_settings(
  			use_automatic_signing: false
		)

	    build_app(args)
  	end
end
