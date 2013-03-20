#!/usr/bin/env ruby

require 'rubygems'
require 'rest_client'
require 'json'
require 'cgi'


def bye
   abort("Usage: #{$0} [view_url]\nExample: #{$0} http://admin:admin@127.0.0.1:5984/logm/_design/workm//_view/task")
end

def delete_documents_from_view_result(url)
   case url
   when /^(https?:\/\/.+?\/.+?)\/_design\/.+?\/_view\/.+/
      db_url = $1
   end

   unless db_url
      bye
   end

   json = JSON.parse(RestClient.get(url))

   json["rows"].each do |row|
      doc_url = db_url + '/' + CGI.escape(row["id"])
      begin
         rev = RestClient.head(doc_url).headers[:etag].gsub('"', '')
         RestClient.delete(doc_url + '?rev=' + rev)
      rescue Exception
         puts "warning: could not delete '#{doc_url}'"
         next
      end
   end
end

unless ARGV[0]
   bye
end
delete_documents_from_view_result(ARGV[0])
