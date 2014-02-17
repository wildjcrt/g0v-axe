# http://axe.g0v.tw/level/1
# ruby axe-01.rb

require 'nokogiri'
require 'open-uri'
require 'json'

array = []
uri   = 'http://axe-level-1.herokuapp.com/'
doc   = Nokogiri::HTML(open(uri))
data  = doc.css('.table tr')
subjects = data.shift.css('td').map &:text

data.each do |tr|
  hash = {:name => '', :grades => {}}
  td = tr.css('td')
  td.each_with_index do |column, i|
    unless i > 0
      hash[:name] = column.text
    else
      hash[:grades][subjects[i]] = column.text.to_i
    end
  end
  array << hash
end

puts array.to_json
