
require 'rmagick'

include Magick

@images = Dir.entries("./public/images/general/original/")

puts "Images:"
puts @images

@images.each do |image|
  next if image  == '.' or image == '..'
  image_path = "./public/images/general/original/#{image}"
  img = Magick::Image::read(image_path)[0]
  img = img.resize_to_fill(100, 100, CenterGravity)
  img.write("./public/images/general/thumbs/tmb_#{image}")
end
