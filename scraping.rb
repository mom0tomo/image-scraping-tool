require 'open-uri'
require 'dotenv'
require 'nokogiri'
require 'net/http'

Dotenv.load
file_count = ''

# scrape images
for number in 1...50 do
  file_name = number.to_s + '.png'
  dir_name = ENV["DIR_NAME"]
  file_count = number.to_s

  num = ('%03d' % number).to_s
  url = ENV["URL"] + num + '.jpg'

  # check responce
  res = Net::HTTP.get_response(URI.parse(url))
  return unless res.code == "200"

  # check, mkdir and cd
  Dir::mkdir(dir_name) and p "mkdir " + dir_name unless Dir.exist?(dir_name)
  Dir.chdir(dir_name)

  open(url) do |file|
    open(file_name, "w+b") do |out|
      out.write(file.read)
      end
  end
end

p file_count + " files were created."

