require 'pp'
IRB.conf[:SAVE_HISTORY] = 100000
IRB.conf[:HISTORY_PATH] = File::expand_path("~/.irb_history")
require 'irb/completion'
require 'irb/ext/save-history'
