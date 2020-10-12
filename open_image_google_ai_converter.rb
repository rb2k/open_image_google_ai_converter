#!/usr/bin/env ruby
require 'dimensions'

if ARGV.size < 2
  puts "usage: #{$PROGRAM_NAME} /path/to/dataset/folder/ google_storage_bucket_name"
  exit
end

dataset_folder = ARGV[0]
google_storage_bucket_name = ARGV[1]

unless File.directory?(dataset_folder)
  puts "Dataset directory not found"
  exit(1)
end


image_dir = Dir["#{dataset_folder}/**/multidata/train/"]
label_dir = File.join(image_dir, 'labels')


Dir[File.join(label_dir, '*.txt')].each do |f|
  # Label txt file has the same prefix as image
  image_name = File.basename(f.gsub(".txt", ".jpg"))
  gs_url = "gs://#{google_storage_bucket_name}/#{image_name}"
  content = IO.read(f)
  coord_type = {}
  
  image_width, image_height = Dimensions.dimensions(File.join(image_dir, image_name))
  
  content.split("\n").each do |single_line|
    split_up = single_line.split(" ")
    label = split_up[0]
    coordinates = split_up[1..-1]
    # I don't think we need more than 2?
    coordinates.map!{ |float| Float(float).round(2)}
    
    absolute_x0 = coordinates[0]
    absolute_y0 = coordinates[1]
    absolute_x1 = coordinates[2]
    absolute_y1 = coordinates[3]
    
    relative_x0 =  absolute_x0 / image_width
    relative_y0 = absolute_y0 / image_height
    relative_x1 = absolute_x1 / image_width
    relative_y1 = absolute_y1 / image_height

    relative_coordinates = [
      relative_x0.round(2),
      relative_y0.round(2),
      relative_x1.round(2),
      relative_y1.round(2)
    ]
    
    coord_type[label] = [] if coord_type[label].nil?
    coord_type[label] << relative_coordinates
  end
  coord_type.each_pair do |label, coords|
    coords.each do |coord|
      puts "TRAIN,#{gs_url},#{label},#{coord[0]},#{coord[1]},,,#{coord[2]},#{coord[3]},,"
    end
  end
end