

def instruct_and_abort_if_user_gave_invalid_input
	if ARGV.empty? 
	  	abort("Error - No input parameter - \
you shall enter '$ mkdiruby name_of_your_ruby_file'")
	end
	 
	if ARGV.size > 1
		 abort("Error - More than 1 input parameter -\
you shall enter '$ mkdiruby name_of_your_new_ruby_file")
	end
end

def create_directory_in_wd(name_directory = "new_dir")
	print "Creating a directory #{name_directory} within the current directory... "
	working_directory_string = Dir.getwd
	new_directory_absolut_path = 
	working_directory_string + '/' + name_directory
	Dir.mkdir(new_directory_absolut_path) 
	puts "Success"
	puts "New directory path: #{new_directory_absolut_path}"
	puts
	return new_directory_absolut_path
end

def move_to_dir(dir_absolute_path)
	print "Moving to the new directory... "
	Dir.chdir(dir_absolute_path)
	puts "Success"
end

def set_directory_and_move_to_it
	new_directory_absolute_path = create_directory_in_wd(ARGV[0].to_s)
	move_to_dir(new_directory_absolute_path)
end

def create_file(filename_str)
	print "Creating #{filename_str}... "
	file = File.open(Dir.getwd.to_s + '/' + filename_str.to_s, 'a+')
	puts "Success"
	return file
end

def copy_gemfile
	print "Copying Gemfile from Gemfile template folder... "
	system("cp '/home/thibaut/Dropbox (Thibaut)/team/3-Job/Formations/5-THP-2019-01/gemfile_template/Gemfile' Gemfile")
	puts "Success"
	puts
	return nil
end

def install_bundle
	print("Running Bundle install... ")
	system('bundle install')
	puts "Success"
	puts
end

def initiate_guard
	print("Running 'guard init' and then 'guard rspec' with bundle...")
	# http://tutorials.jumpstartlab.com/topics/internal_testing/rspec_practices.html
	system('bundle exec guard init')
	# system('guard rspec')
	system('bundle exec guard')
	puts "Success"
	puts

end

def initiate_github
	print('Creating a Remote Repository on Github... ')
	system('hub init')
	system('hub create ' + ARGV[0].to_s)
	print('Pushing existing content into remote... ')
	system('hub add .')
	system('hub commit -m "Folder initialisation"')
	system('hub push -u origin master')
	puts("Success") 
	puts
end



def perform
	instruct_and_abort_if_user_gave_invalid_input
	
	set_directory_and_move_to_it
	puts

	copy_gemfile

	install_bundle

	create_directory_in_wd("lib")
	puts
	
	system('git init')
	puts
	
	env_file = create_file('.env')
	env_file.close
	puts

	gitignore_file = create_file('.gitignore')
	gitignore_file.write('.env')
	gitignore_file.close
	puts

	system('rspec --init')
	puts

	print "Copying README template file ... "
	system("cp '/home/thibaut/Dropbox (Thibaut)/team/3-Job/Formations/5-THP-2019-01/readme_template/README.md' README.md" )
	puts "Success"
	puts

	print "Copying RSPEC template file ... "
	system("cp '/home/thibaut/Dropbox (Thibaut)/team/3-Job/Formations/5-THP-2019-01/rspec_template/template_spec.rb' spec/template_spec.rb" )
	puts "Success"
	puts

	# http://tutorials.jumpstartlab.com/topics/internal_testing/rspec_practices.html
	# https://github.com/guard/guard
	# initiate_guard

	initiate_github

	puts "END"
end

perform
