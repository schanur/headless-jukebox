#!/usr/bin/env ruby
# coding: utf-8

require 'rubygems'
require 'bundler/setup'

require 'pp'
require 'io/console'

require 'open3'
require 'benchmark'

require_relative 'headless-jukebox/command_attribute_mapping.rb'
require_relative 'headless-jukebox/command_param_function_helpers.rb'
require_relative 'headless-jukebox/command_param_functions.rb'
require_relative 'headless-jukebox/keyboard_mapping.rb'
require_relative 'headless-jukebox/platform_mapping.rb'



platform_list = [
  :raspberry,
  :pc
]

# TODO: Better separation. Currently all ARM boards are recognized as Raspberry Pis.
def platform()
  arch, os, abi = RUBY_PLATFORM.split('-')
  case arch
  when 'x86_64'
    :pc
  when 'arm'
    :raspberry
  else
    raise 'Unknown platform'
  end
end

required_modules = {
  :raspberry => [
    'mpv', 'omxplayer'
  ],
  :pc => [
    'mpv'
  ]
}

def mpv_callback(event)
  puts "mpv: #{event.to_s}"
end

def omx_callback(event)
  puts "omx: #{event.to_s}"
end

def load_modules(module_list)
  module_list.each { |module_name|
    puts "Load module: " + module_name
    require module_name
  }
end

def platform_mapping(platform, command_type)
  raise "platform is nil" if platform.nil?
  raise "command_type is nil" if command_type.nil?
  puts "2: " + platform.to_s
  puts "3: " + command_type.to_s
  mapping = $platform_application_mapping[platform][command_type]
  # raise "No platform application mapping found for platform:" + platform.to_s + " command_type: " + command_type if mapping.nil?
  return mapping
end

def set_volume(active_player)
  # case active_player do
  #      when 'mpv'

  #      when
end

# module OMX
#   class Server < MPV::Server
#   end
# end

platform = platform()
puts 'Platform: ' + platform.to_s
puts "Load modules"
load_modules required_modules[platform]
mpv_session = nil
puts "start MPV background session"
puts Benchmark.measure {
  mpv_session = MPV::Session.new # contains both a MPV::Server and a MPV::Client
}.real
puts "done"
omx_session = nil
# if platform == :raspberry
#   puts "start OMX background session"
#   puts Benchmark.measure {
#     omx_session = Omxplayer.instance
#     # omx_session.open("silence_60.oga")
#     omx_session.open("sintel-1280-stereo.mp4")
#   }.real
#   puts 'sleep'
#   sleep 10
#   puts 'done'
#   omx_session.action(:pause)
# end

mpv_session.callbacks << MPV::Callback.new(self, :something_happened)
# pp   session.set_property "pause", true
puts 'Version'
puts mpv_session.command "get_version"

puts "Command loop started.\n"


quit = false
while (1) do
  begin
    pressed_key = STDIN.getch
    puts "-----------------------------------"
    if $keyboard_mapping.has_key? pressed_key
      action = $keyboard_mapping[pressed_key]
    else
      action = :stop
    end

    command = $command_attributes[action]
    if command.nil?
      command=[nil, nil]
    end
    puts ">>>" + command[0].to_s
    app_mapping = platform_mapping(platform(), command[0])
    puts ">>>"
    pp app_mapping.to_s
    detailed_application_command = $detailed_application_command[app_mapping]

    cmd = {:platform                          => platform(),
           :key                               => pressed_key,
           :key_has_mapping                   => $keyboard_mapping.has_key?(pressed_key),
           :high_level_action                 => action,
           :command_type                      => command[0],
           :command_param                     => command[1],
           :evaluated_command_param           => if command[1].respond_to? :call then command[1].call else command[1] end,
           :command_has_platform_application  => app_mapping != nil,
           :application                       => app_mapping,
           :detailed_application_command      => detailed_application_command
          }
    #         :application                       => app_mapping[0],
    #         :application_command               => app_mapping[1]

    pp cmd
    puts


    # case cmd[:command_type]
    case cmd[:command_type]
    when :audio_stream, :audio_file
      puts cmd[:command_type].to_s
      case cmd[:detailed_application_command][0]
      when 'mpv'
        puts "mpv"
        # mpv_session.command cmd[:detailed_application_command[1]], cmd[:detailed_application_command[2]]
        mpv_session.command cmd[:detailed_application_command][2], cmd[:evaluated_command_param]
      when 'omx'
        puts "omx"
      else
        raise "What is: " + cmd[:detailed_application_command][0].to_s
      end
    when :video_stream
      puts cmd[:command_type].to_s
      case cmd[:detailed_application_command][0]
      when 'mpv'
        puts "mpv"
        # mpv_session.command cmd[:detailed_application_command[1]], cmd[:detailed_application_command[2]]
        mpv_session.command cmd[:detailed_application_command][2], cmd[:evaluated_command_param]
      when 'omx'
        puts "omx"
        omx_session = Omxplayer.instance
        omx_session.open(cmd[:evaluated_command_param])
      # omx_session.
      else
        raise "What is: " + cmd[:detailed_application_command][0].to_s
      end
    when :mpv_set_property
      puts "mpv_set_property"
      mpv_session.set_property cmd[:command_param]# , command[2]
    when :ignore
      puts "ignore"
      next
    when :stop
      puts "stop"
      omx_session.action(:quit)
      mpv_session.set_property 'pause', 'true'
    when :quit
      puts "quit"
      quit = true
      break
    end

  rescue Exception => e
    puts e.message
    puts e.backtrace.inspect
    quit = true
  end

  if quit == true
    break
  end
end

if omx_session != nil?
  omx_session.action(:quit)
end

mpv_session.quit!
