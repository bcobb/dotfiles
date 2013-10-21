%w[
  rubygems
  irb/completion
  irb/ext/save-history
  pp
].each do |path|
  begin
    require path
  rescue LoadError
    printf "\e[1;31m!\e[0m"
  end
end

IRB.conf[:PROMPT][:CUSTOM] = {
  :PROMPT_I => "> ",
  :PROMPT_N => ".. ",
  :PROMPT_S => ".. ",
  :PROMPT_C => ".. ",
  :RETURN   => "= %s\n"
}

IRB.conf[:AUTO_INDENT]  = true
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"
IRB.conf[:PROMPT_MODE]  = :CUSTOM
IRB.conf[:SAVE_HISTORY] = 10000
IRB.conf[:USE_READLINE] = true

IRB.conf[:LOAD_MODULES] ||= %w[irb/completion irb/ext/save-history]

puts "\n#{RUBY_DESCRIPTION}"
