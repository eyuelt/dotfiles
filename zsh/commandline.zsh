# use up/down keys on the command line to do <Ctrl-R>-style reverse-i-search
# through history using the substring before the cursor on the current line
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

# use <Ctrl-Left> and <Ctrl-Right> to jump from word to word
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
