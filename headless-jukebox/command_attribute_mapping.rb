$command_attributes = {
  :deutschlandfunk             => [:audio_stream,      'http://www.deutschlandradio.de/streaming/dlf_hq_ogg.m3u'    ],
  :deutschlandradio_kultur     => [:audio_stream,      'http://www.deutschlandradio.de/streaming/dkultur_hq_ogg.m3u'],
  :dradio_wissen               => [:audio_stream,      'http://dradio-ogg-dwissen-l.akacast.akamaistream.net/7/192/135496/v1/gnl.akacast.akamaistream.net/dradio_ogg_dwissen_l'],

  :tagesschau                  => [:video_stream,      lambda { video_feed_url_to_video_url 'http://www.tagesschau.de/export/video-podcast/webxl/tagesschau/'}],
  :tagesschau_latest_news_show => [:video_stream,      lambda { video_feed_url_to_video_url 'http://www.tagesschau.de/download/podcast/index.html' }],

  :marvel_epic_soundtrack      => [:audio_file,        '/home/pi/local/media/music/1_Hour_Epic_Battle_Marvel_Music.opus'],
  :epic_soundtrack_1           => [:audio_file,        '/home/pi/local/media/music/epic_2.opus'],
  :ghibli_soundtrack           => [:audio_file,        '/home/pi/local/media/music/ghibli_soundtrack.opus'],

  :classic_mix                 => [:audio_file,        '/home/pi/local/media/music/best_of_classic.opus'],
  :dark_minimal_techo_mix      => [:audio_file,        '/home/pi/local/media/music/dark_minimal_techno_mix_set_2015.opus'],

  :secret_of_mana_soundtrack   => [:audio_file,        lambda { random_media_file_in_path '/media/fs1/music/soundtracks/Games/Secret_of_Mana'}],

  :custom_1                    => [:audio_file,        '/home/pi/local/media/music/custom1.opus'],
  :custom_2                    => [:audio_file,        '/home/pi/local/media/music/custom2.opus'],
  :custom_3                    => [:audio_file,        '/home/pi/local/media/music/custom3.opus'],

  :volume0                     => [:set_volume,        '0'  ],
  :volume20                    => [:set_volume,        '20' ],
  :volume30                    => [:set_volume,        '30' ],
  :volume40                    => [:set_volume,        '40' ],
  :volume50                    => [:set_volume,        '50' ],
  :volume60                    => [:set_volume,        '60' ],
  :volume70                    => [:set_volume,        '70' ],
  :volume80                    => [:set_volume,        '80' ],
  :volume90                    => [:set_volume,        '90' ],
  :volume100                   => [:set_volume,        '100'],

  :pause                       => [:mpv_set_property,  'pause',     'toggle'],
  # :stop                        => [:mpv_set_property,  'stop'],
  :stop                        => [:stop,  'stop'],

  :ignore                      => [:ignore],

  :hot_reload                  => [:hot_reload],
  :quit                        => [:quit],
}
