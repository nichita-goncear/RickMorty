platform :ios do

	desc "Distribute to Firebase. 🚚"
	desc "- group: Testing group ID e.g. 'internal', 'external', 'dev', etc."
	lane :upload_to_firebase do |parameters| 

		UI.user_error! "Missing parameter 'group'" unless parameters.has_key?(:group)

		testing_group = parameters[:group]

		last_commit_msg = last_git_commit[:message]

		firebase_app_distribution(
			app: ENV["FIREBASE_DEV_APP_ID"],
			groups: testing_group,
		    release_notes: last_commit_msg,
	   	    firebase_cli_path: "/usr/local/bin/firebase",
			ipa_path: ENV["OUTPUT_IPA_PATH_FULL"]
	 	)
	end
end