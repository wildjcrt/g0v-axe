# http://axe.g0v.tw/level/2
# ruby axe-02.rb

require 'nokogiri'
require 'open-uri'
require 'json'

array = []
pages = 12
pages.times do |i|
  uri   = "http://axe-level-1.herokuapp.com/lv2/?page=#{i+1}"
  doc   = Nokogiri::HTML(open(uri))
  data  = doc.css('.table tr')
  keys  = data.shift.css('td').map do |value|
            case value.text
            when '鄉鎮' then :town
            when '村里' then :village
            when '姓名' then :name
            end
          end

  data.each do |tr|
    hash = {}
    td = tr.css('td')
    td.each_with_index do |column, i|
      hash[keys[i]] = column.text
    end
    array << hash
  end
end

puts array.to_json
