

@webms = Dir.entries("./public/webms/general/original/")

puts "Webms:"
puts @webms

@webms.each do |webm|
  next if webm  == '.' or webm == '..'
  webm_path = "./public/webms/general/original/#{image}"
  webm_destination = "./public/webms/general/thumbs/#{image}"

  `ffmpeg -i #{webm_path} 00:00:02.000 -vframes 1 #{webm_destination.sub! '.webm', '.jpg'}`
end
