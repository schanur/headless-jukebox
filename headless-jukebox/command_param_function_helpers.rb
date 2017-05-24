def run_cmd(command_str)
  puts 'Run external program:      ' + command_str
  # stdout = system(command_str) ; result=$?.success?
  stdout = Open3.popen3(command_str) { |stdin, stdout, stderr, wait_thr| stdout.read }
  puts 'External program returned: >> ' + stdout + ' <<'
  # raise "Command failed: " + command_str if result != true
  return stdout
end

def absolute_file_entries(path)
  Dir.entries(path).reject{|entry| entry == "." || entry == ".."}.map do |relative_filename|
    File.join(path, relative_filename)
  end
end

def is_audio_file(filename)
  supported_audio_suffix = [
    '.3gp',
    '.aa',
    '.aac',
    '.aax',
    '.act',
    '.aiff',
    '.amr',
    '.ape',
    '.au',
    '.awb',
    '.dct',
    '.dss',
    '.dvf',
    '.flac',
    '.gsm',
    '.iklax',
    '.ivs',
    '.m4a',
    '.m4b',
    '.m4p',
    '.mmf',
    '.mogg',
    '.mp3',
    '.mpc',
    '.msv',
    '.oga',
    '.ogg',
    '.opus',
    '.ra',
    '.raw',
    '.rm',
    '.sln',
    '.tta',
    '.vox',
    '.wav',
    '.webm',
    '.wma',
    '.wv',
  ]

  supported_audio_suffix.include?(File.extname(filename))
end

def is_video_file(filename)
  supported_video_suffix = [
    '.3g2',  # Cell phones
    '.3gp',  # Cell phones
    '.amv',
    '.asf',  # Advanced Systems Format
    '.avi',
    '.drc',
    '.f4p',
    '.f4v',
    '.flv',
    '.m4p',
    '.m4v',
    '.m4v',
    '.mkv',
    '.mov',
    '.mp2',
    '.mp4',
    '.mpe',  # Windows 8.3 filename convention
    '.mpeg',
    '.mpg',
    '.mpv',
    '.ogg',
    '.ogv',
    '.qt',   # QuickTime
    '.rm',   # Real media
    '.rmvb', # Real media variable bitrate
    '.svi',
    '.vob',
    '.webm',
    '.wmv',  # Windows media video
    '.yuv',  # Raw video format
  ]

  supported_video_suffix.include?(File.extname(filename))
end

def is_media_file(filename)
  is_audio_file(filename) or is_video_file(filename)
end

# Filter out all non media filenames.
def media_file_list_from_list(filename_list)
  filename_list.select do |filename|
    puts "Drop file. No media file: " + filename if !is_media_file(filename)
    is_media_file(filename)
  end
end
