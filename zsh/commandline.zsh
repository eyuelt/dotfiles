# use up/down keys on the command line to do <Ctrl-R>-style reverse-i-search
# through history using the substring before the cursor on the current line
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward
