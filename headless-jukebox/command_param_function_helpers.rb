def run_cmd(command_str)
  puts 'Run external program:      ' + command_str
  # stdout = system(command_str) ; result=$?.success?
  stdout = Open3.popen3(command_str) { |stdin, stdout, stderr, wait_thr| stdout.read }
  puts 'External program returned: >> ' + stdout + ' <<'
  # raise "Command failed: " + command_str if result != true
  return stdout
end
