
Dir.entries("/app/public/webms/").each do |folder|
  unless folder == '.' || folder == '..'
     @originals = "/app/public/webms/#{folder}/original/"
     @thumbs = "/app/public/webms/#{folder}/thumbs/"

    Dir.entries(@originals).each do |webm|
      if webm.include? ".webm"
        webm_path = "#{@originals}#{webm}"
        webm_destination = "#{@thumbs}#{webm}"

        puts "webm_path: #{webm_path}"
        puts "webm_destination: #{webm_destination}"
        puts "webm_destination.sub!: #{webm_destination.sub! '.webm', '.jpg'}"

        webm_destination_sub = webm_destination.sub! '.webm', '.jpg'

        puts webm_path.inspect
        puts webm_destination.inspect
        puts webm_destination_sub.inspect

        unless File.file?(webm_destination.sub! '.webm', '.jpg')
          `ffmpeg -i '#{webm_path}' -ss 00:00:02.000 -vframes 1 '#{webm_destination.sub! '.webm', '.jpg'}'`
        end
      end
    end
  end
end
