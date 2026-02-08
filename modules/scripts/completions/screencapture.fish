complete -c screencapture -f
complete -c screencapture -a "shot" -d "Take screenshot"
complete -c screencapture -a "record" -d "Record screencast"
complete -c screencapture -n "__fish_seen_subcommand_from shot" -a "all monitor area" -d "Screenshot mode"
complete -c screencapture -n "__fish_seen_subcommand_from record" -a "all area" -d "Record mode"
