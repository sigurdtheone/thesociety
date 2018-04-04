
@webms = Dir.entries("./public/webms/general/original/")

@webms.each do |webm|
  next if webm  == '.' or webm == '..'
  webm_path = "./public/webms/general/original/#{webm}"
  webm_destination = "./public/webms/general/thumbs/#{webm}"

  `ffmpeg -i #{webm_path} -ss 00:00:02.000 -vframes 1 #{webm_destination.sub! '.webm', '.jpg'}`
end
