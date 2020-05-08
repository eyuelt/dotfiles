# use up/down keys on the command line to do <Ctrl-R>-style reverse-i-search
# through history using the substring before the cursor on the current line
# Note: whether to use \e[A or \eOA varies by machine (e.g. I had to do \e[A on
# an Ubuntu machine, while I had to do \eOA on a RPi running Raspbian), so we
# just define both here.
bindkey "\e[A" history-beginning-search-backward
bindkey "\eOA" history-beginning-search-backward
bindkey "\e[B" history-beginning-search-forward
bindkey "\eOB" history-beginning-search-forward

# use <Ctrl-Left> and <Ctrl-Right> to jump from word to word
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
