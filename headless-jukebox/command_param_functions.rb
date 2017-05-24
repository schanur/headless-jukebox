require 'pp'

def video_feed_url_to_video_url(feed_url)
  run_cmd('curl -s ' + feed_url + ' | grep ".h264.mp4" | cut -f 2 -d "\"" |head -n 1')
    .gsub("\n", '')
end

# Scramble list order and return first item that is a media filename.
def random_media_file_from_list(filename_list)
  filename_list.shuffle.each do |filename|
    puts "Drop " + + ". No media filename" if !is_media_file(filename)
    return filename
  end
  raise "No media file found in list of files."
end

# Scramble order and filter out all non media filenames.
def random_media_file_list_from_list(filename_list)
  media_file_list_from_list(filename_list).shuffle
end

def random_media_file_list_in_path(path)
  raise "Path does not exist:" + path if !File.directory?(path)
  pp Dir.entries(path)
  random_media_file_list_from_list(absolute_file_entries(path))
end

# Return single random media filename in path.
def random_media_file_in_path(path)
  raise "Path does not exist:" + path if !File.directory?(path)
  random_media_file_from_list(absolute_file_entries(path))
end
