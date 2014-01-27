
require 'irb/completion'

IRB.conf[:AUTO_INDENT]  = false
IRB.conf[:USE_READLINE] = true

require 'irb/ext/save-history'
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:EVAL_HISTORY] = 200
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"

