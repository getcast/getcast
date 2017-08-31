require 'rss'
require 'open-uri'

url = 'https://jovemnerd.com.br/'
#https://jovemnerd.com.br/feed-nercast/
s1 = Time.now
open(url) do |rss|
  s2 = Time.now
  puts s2 - s1
  s1 = Time.now
  begin
   feed = RSS::Parser.parse(rss, false)
  rescue
   puts "No RSS/XLM code"
   exit
  end
  s2 = Time.now
  puts s2 - s1
  puts "Title: #{feed.channel.title}"
  puts "Description: #{feed.channel.description}"
  puts feed.items.class
  feed.items.each do |item|
    item.to_s[/"(.*?).mp3"/]
   end
end

