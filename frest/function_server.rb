=begin
  Open a permanent listen() connection to Postgres, through which we can execute functions server-side
=end

require 'json'
require 'v8'
require_relative 'settings'

f = fork
if f
  Process.detach f
else
  require_relative 'settings'
  d = Frest::database
  loop do
    Frest::database.exec "LISTEN exec_fn"
    d.wait_for_notify do |chan, pid, message|
      p message
      j = JSON.decode(message)

      # We only support javascript currently
      # lang    = j['lang']
      args    = j['args']

      c = V8::Context.new
    end
  end
end
