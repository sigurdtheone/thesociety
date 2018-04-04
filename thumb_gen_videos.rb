


Dir.entries("./public/webms/").each do |folder|
  unless folder == '.' || folder == '..'
     originals = "./public/webms/#{folder}/original/"
     thumbs = "./public/webms/#{folder}/thumbs/"

    Dir.entries(originals).each do |webm|
      next if webm  == '.' or webm == '..'
      webm_path = "#{originals}#{webm}"
      webm_destination = "#{thumbs}#{webm}"

      `ffmpeg -i #{webm_path} -ss 00:00:02.000 -vframes 1 #{webm_destination.sub! '.webm', '.jpg'}`
    end
  end
end
