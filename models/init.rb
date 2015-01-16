Dir[File.dirname(__FILE__) + '/*.rb'].each do |file|
	next if file == 'init'
 	require_relative file 
end
