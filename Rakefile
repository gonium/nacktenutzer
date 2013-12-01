require 'webrick'
require 'directory_watcher'
require "term/ansicolor"
require "jekyll"
require "rdiscount"
require "yaml"
include Term::ANSIColor
include WEBrick

host_var = YAML::load(File.open('deploy.yml'))


task :default => :develop
 
desc 'Build site with Jekyll.'
task :build => :tags do
	printHeader "Compiling website..."
	options = Jekyll.configuration({})
	@site = Jekyll::Site.new(options)
	@site.process
end
 
def globs(source)
	Dir.chdir(source) do
		dirs = Dir['*'].select { |x| File.directory?(x) }
		dirs -= ['_site']
		dirs = dirs.map { |x| "#{x}/**/*" }
		dirs += ['*']
	end
end

desc 'Enter development mode.'
task :develop => :build do
	printHeader "Auto-regenerating enabled."
	directoryWatcher = DirectoryWatcher.new("./")
	directoryWatcher.interval = 1
	directoryWatcher.glob = globs(Dir.pwd)
	directoryWatcher.add_observer do |*args| @site.process end
	directoryWatcher.start
	mimeTypes = WEBrick::HTTPUtils::DefaultMimeTypes
	mimeTypes.store 'js', 'application/javascript'
	server = HTTPServer.new(
		:BindAddress	=> "localhost",
		:Port			=> 4000,
		:DocumentRoot	=> "_site",
		:MimeTypes		=> mimeTypes,
		:Logger			=> Log.new($stderr, Log::ERROR),
		:AccessLog		=> [["/dev/null", AccessLog::COMBINED_LOG_FORMAT ]]
	)
	thread = Thread.new { server.start }
	trap("INT") { server.shutdown }
	printHeader "Development server started at http://localhost:4000/"
	#printHeader "Opening website in default web browser..."
	#%x[open http://localhost:4000/]
	printHeader "Development mode entered."
	thread.join()
end

desc 'Remove all built files.'
task :clean do
	printHeader "Cleaning build directory..."
	%x[rm -rf _site]
end

desc 'Build, deploy, then clean.'
task :deploy => :build do
  domain = "nacktekunden.de"
	printHeader "Deploying website to #{domain}"
	sh "rsync -rzh _site/ #{host_var['DEPLOY_USER']}@#{host_var['DEPLOY_HOST']}:/var/www/#{domain}/"
	Rake::Task['clean'].execute
end


