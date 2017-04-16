def video_feed_url_to_video_url(feed_url)
  run_cmd('curl -s ' + feed_url + ' | grep ".h264.mp4" | cut -f 2 -d "\"" |head -n 1')
    .gsub("\n", '')
end
