#!/usr/bin/env ruby

require 'find'

week=ARGV[0]
projMap = {}

LOCAL_DIR="#{ENV['HOME']}/Library/Application Support/Notational Data"
DROPBOX_DIR="#{ENV['HOME']}/Dropbox/Application Support/Notational Data"

has_files_in_local_dir = Dir[LOCAL_DIR + "/*"].length > 2
workdir = has_files_in_local_dir ? LOCAL_DIR : DROPBOX_DIR

Dir.glob("#{workdir}/log- #{week}*") do |path|
   # puts path

   open(path) do |file|
      file.grep(/@effort\(.*\)/).each do |effline|
         # puts effline

         match = effline.match(/@effort\((.*)\)/)
         if(match) then
            match[1].split(',').each do |term|
               arr = term.strip.split(":")
               # puts arr.inspect

               projMap[arr[0]] = 0 unless projMap.has_key?(arr[0])
               projMap[arr[0]] = projMap[arr[0]] + arr[1].to_f
            end
         end

      end
   end

   # puts "\n"
end

puts projMap.inspect
puts "Total: #{projMap.values.reduce(:+)}"
