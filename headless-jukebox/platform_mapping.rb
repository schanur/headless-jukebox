$detailed_application_command = {
  :mpv_video_stream   => ['mpv',  'command',          'loadfile'],
  :mpv_audio_stream   => ['mpv',  'command',          'loadfile'],
  :mpv_audio_file     => ['mpv',  'command',          'loadfile'],
  :mpv_audio_playlist => ['mpv',  'custom',           'playlist'],
  :mpv_set_volume     => ['mpv',  'mpv_set_property', 'ao-volume'],


  :omx_video_playlist => ['omx',  'custom',           'playlist'],
  :omx_video_stream   => ['omx',  'command',          'loadfile'],
  :omx_audio_stream   => ['omx',  'command',          'loadfile'],
  :omx_audio_file     => ['omx',  'command',          'loadfile'],


  :alsa_set_volume    => ['alsa', 'set'],
}

$platform_application_mapping = {
  :pc => {
    :video_stream   => :mpv_video_stream,
    :video_file     => :mpv_video_file,
    :audio_stream   => :mpv_audio_stream,
    :audio_file     => :mpv_audio_file,
    :audio_playlist => :mpv_audio_playlist,
    :set_volume     => :mpv_set_volume
  },
  :raspberry => {
    :video_stream   => :omx_video_stream,
    :video_file     => :omx_video_file,
    :audio_stream   => :mpv_audio_stream,
    :audio_file     => :mpv_audio_file,
    :audio_playlist => :mpv_audio_playlist,
    :set_volume     => :alsa_set_volume
  }
}
