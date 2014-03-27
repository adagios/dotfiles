#!/usr/bin/env ruby

require 'Date'

DATE_FMT="%b %d %Y"

author=ARGV[1]||`git config --get user.email`.chomp
today= Date.today

n_weeks_before=ARGV[0].to_i||0

today=today + n_weeks_before * 7

last_week_start = (today - (6 + today.wday)).strftime(DATE_FMT)
last_week_end = (today - today.wday).strftime(DATE_FMT)

puts "Listing commits by #{author} between #{last_week_start} and #{last_week_end}"
puts "============================================================================\n\n"

Dir.foreach('.') do |f|
   next unless File.directory? f #only dirs
   next if f =~ /\.+/  #skip . and ..

   Dir.chdir(f) do |dir|
      if Dir.new('.').include?('.git')
         output=`git log --all --color --author="#{author}" --after="#{last_week_start}" --before="#{last_week_end}" --pretty=format:'%Cred%ad %Cgreen%d%Creset%s' --date=short`

         if output.length>0 then
            puts f
            puts "-"*f.length

            puts "#{output}\n\n"
         end
      end

   end
end
