#!/usr/bin/env ruby

require 'Date'

DATE_FMT="%b %d %Y"

author=`git config --get user.email`.chomp
today= Date.today

last_week_start = (today - (7 + today.wday)).strftime(DATE_FMT)
last_week_end = (today - (0 + today.wday)).strftime(DATE_FMT)

puts "Listing commits by #{author} between #{last_week_start} and #{last_week_end}"
puts "============================================================================\n\n"

Dir.foreach('.') do |f|
   next unless File.directory? f #only dirs
   next if f =~ /\.+/  #skip . and ..
   next unless Dir.new(f).include? '.git' #only git repos

   Dir.chdir(f) do |dir|
      output=`git log --all --color --author #{author} --after="#{last_week_start}" --before="#{last_week_end}" --oneline`

      if output.length>0 then
         puts f
         puts "-"*f.length

         puts "#{output}\n"
      end

   end
end

