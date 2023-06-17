platform :ios do

	desc "Running unit tests.. 🧪🔬"
	lane :run_unit_tests do
	  	
	    sh(" if [ ! -d #{project_directory} ] then mkdir #{project_directory} fi ")
	  	
	  	run_tests(clean: true,
	        fail_build: false,
	        scheme: test_scheme,
	        code_coverage: true,
	        device: "iPhone 14",
	        output_types: "html,junit",
	        output_directory: "Reports/"
	    )
	end
end