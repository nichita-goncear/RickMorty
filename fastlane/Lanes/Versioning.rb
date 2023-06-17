platform :ios do

	desc "Bump build number.. 🆙"
	desc "Increase and commit new build number."
	lane :bump_build_number do

		ensure_git_status_clean

	  	increment_build_number(
	  		xcodeproj: project
	  	)

	  	commit_version_bump(
		 message: "CI: Bump build number to #{get_build_number}",
		 xcodeproj: project
		)

	end
end