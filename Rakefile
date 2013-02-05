require 'rake/clean'

VIMDIR    = File.expand_path('~/.vim')
BUNDLEDIR = File.join(VIMDIR, 'bundle')
OS        = case RUBY_PLATFORM
            when /linux/  then 'linux'
            when /darwin/ then 'mac'
            end
 
if OS.nil?
  warn "Unsupported os!\n"
  exit 1
end

task :default => 'help'

task :help do
  puts 
  puts 'rake install'
  puts
end

desc 'install'
task :install do
  Dir.mkdir BUNDLEDIR unless File.exists
end

desc 'bundle'
task :bundle do
  sh 'vim +NeoBundleInstall +qall'
end

desc 'update'
task :update do
  Dir.chdir VIMDIR do
    sh 'git pull'
    sh 'vim +NeoBundleUpdate +qall'
  end
end
