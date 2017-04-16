$detailed_application_command = {
  :mpv_audio_stream => ['mpv',  'command',          'loadfile'],
  :mpv_video_stream => ['mpv',  'command',          'loadfile'],
  :mpv_audio_file   => ['mpv',  'command',          'loadfile'],
  :mpv_set_volume   => ['mpv',  'mpv_set_property', 'ao-volume'],


  :omx_audio_stream => ['omx',  'command',          'loadfile'],
  :omx_video_stream => ['omx',  'command',          'loadfile'],
  :omx_audio_file   => ['omx',  'command',          'loadfile'],


  :alsa_set_volume  => ['alsa', 'set'],
}

$platform_application_mapping = {
  :pc => {
    :audio_stream => :mpv_audio_stream,
    :video_stream => :mpv_video_stream,
    :audio_file   => :mpv_audio_file,
    :set_volume   => :mpv_set_volume
  },
  :raspberry => {
    :audio_stream => :mpv_audio_stream,
    :video_stream => :omx_video_stream,
    :audio_file   => :mpv_audio_file,
    :set_volume   => :alsa_set_volume
  }
}
