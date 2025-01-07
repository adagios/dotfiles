require 'rake'
require 'erb'

desc "backup applescripts from this computer"
task :backup_applescripts do
  system %Q{cp -rf "$HOME/Library/Scripts"/* "$PWD/applescripts"}
end

desc "install the dot files into user's home directory"
task :install do
  replace_all = false

  files = Dir['*'] - %w[Rakefile README.rdoc LICENSE applescripts Library]
  files = files - Dir['*bash*'] - %W[inputrc] unless ENV['SHELL'].end_with? 'bash'
  files = files - Dir['*zsh*']                unless ENV['SHELL'].end_with? 'zsh'
  files = files - %W[iTerm]                   if     ENV['iterm'] == 'false'

  #files.each do |file|
  #  destination = File.join(ENV['HOME'], ".#{file.sub('.erb','')}")
  #  printf "%-20s : %-30s : %s \n", file, destination, File.exist?(destination)
  #end
  #exit

  files.each do |file|
    process_file(file, replace_all)
  end

  # Recursively process files inside Library
  #TMP# Dir.glob("Library/**/*").reject{|f| File.directory? f}.each do |file|
     #TMP# process_file(file, replace_all, "")
  #TMP# end

  #Hack copy applescripts into Library/Scripts
  #TMP# system %Q{mkdir "$HOME/Library/Scripts" || rm -rf "$HOME/Library/Scripts/*"}
  #TMP# system %Q{cp -rf "$PWD/applescripts"/* "$HOME/Library/Scripts/"}
end

def process_file(file, replace_all, prefix=".")
   if File.exist?(File.join(ENV['HOME'], "#{prefix}#{file.sub('.erb', '')}"))
      if File.identical? file, File.join(ENV['HOME'], "#{prefix}#{file.sub('.erb', '')}")
         puts "identical ~/#{prefix}#{file.sub('.erb', '')}"
      elsif replace_all
         replace_file(file, prefix)
      else
         print "overwrite ~/#{prefix}#{file.sub('.erb', '')}? [ynaq] "
         case $stdin.gets.chomp
         when 'a'
            replace_all = true
            replace_file(file, prefix)
         when 'y'
            replace_file(file, prefix)
         when 'q'
            exit
         else
            puts "skipping ~/#{prefix}#{file.sub('.erb', '')}"
         end
      end
   else
      link_file(file, prefix)
   end
end

def replace_file(file, prefix)
  system %Q{rm -rf "$HOME/#{prefix}#{file.sub('.erb', '')}"}
  link_file(file, prefix)
end

def link_file(file, prefix)
  if file =~ /.erb$/
    puts "generating ~/#{prefix}#{file.sub('.erb', '')}"
    File.open(File.join(ENV['HOME'], "#{prefix}#{file.sub('.erb', '')}"), 'w') do |new_file|
      new_file.write ERB.new(File.read(file)).result(binding)
    end
  else
    puts "linking ~/#{prefix}#{file}"
    system %Q{ln -s "$PWD/#{file}" "$HOME/#{prefix}#{file}"}
  end
end
