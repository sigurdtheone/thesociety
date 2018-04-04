
Dir.entries("/app/public/webms/").each do |folder|
  unless folder == '.' || folder == '..'
     @originals = "/app/public/webms/#{folder}/original/"
     @thumbs = "/app/public/webms/#{folder}/thumbs/"

    Dir.entries(@originals).each do |webm|
      if webm.include? ".webm"
        webm_path = "#{@originals}#{webm}"
        webm_destination = "#{@thumbs}#{webm}"

        unless File.file?(webm_destination.sub! '.webm', '.jpg')
          `ffmpeg -i #{webm_path} -ss 00:00:02.000 -vframes 1 #{webm_destination.sub! '.webm', '.jpg'}`
        end
      end
    end
  end
end
