require 'launchy'

def instruct_and_abort_if_user_gave_no_input
  if ARGV.empty?
  	abort("Error - Search input empty - you shall enter '$ ruby google_searcher.rb 'your search on Google''")
  end
end

def build_google_search_url
	'https://www.google.com/search?q='+ARGV.to_a.join('+')
end

def launch_google_search
	Launchy.open(build_google_search_url)
end

def perform
	instruct_and_abort_if_user_gave_no_input
	launch_google_search
end

perform