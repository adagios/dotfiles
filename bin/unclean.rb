#!/usr/bin/env ruby

verbose=false

ARGV.each do |arg|
   verbose = true if arg == '-v'
end

dirties = []
Dir.foreach('.') do |f|
   next unless File.directory? f #only dirs
   next if f =~ /\.+/  #skip . and ..

   Dir.chdir(f) do |dir|
      break unless Dir.new('.').include? '.git'
      output=`git status --porcelain`

      if output.length>0 then
         dirties << [dir, output]
      end

   end
end

unless dirties.empty?
   puts "Dirty repos"
   puts "===========\n\n"

   dirties.each do |d|
      puts d[0]
      if verbose
         puts "-"*d[0].size
         puts d[1]
         puts "\n"
      end
   end
   puts "\n"

end

