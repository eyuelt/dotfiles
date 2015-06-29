if [ "$(uname -s)" = "Darwin" ]
then
  export LSCOLORS="exfxcxdxbxegedabagacad"
  export CLICOLOR=true
else if [ "$(uname -s)" = "Linux" ]
  export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:"
fi

#fpath=($DOTFILES/functions $fpath)
#autoload -U $DOTFILES/functions/*(:t)

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt NO_BG_NICE            # don't nice background tasks
setopt NO_HUP                # don't send HUP signal to running jobs when the shell exits
setopt NO_LIST_BEEP          # don't beep when ambiguous completions
setopt LOCAL_OPTIONS         # allow functions to have local options
setopt LOCAL_TRAPS           # allow functions to have local traps
setopt PROMPT_SUBST          # parameter expansion, command substitution, arithmetic expansion
setopt CORRECT               # spell correction
setopt COMPLETE_IN_WORD      # autocomplete from cursor even if cursor is in middle of word
setopt IGNORE_EOF            # don't exit on EOF (use exit or logout commands to exit)

setopt APPEND_HISTORY        # adds history
setopt INC_APPEND_HISTORY    # adds history incrementally
setopt EXTENDED_HISTORY      # add timestamps to history
setopt SHARE_HISTORY         # share history across sessions
setopt HIST_IGNORE_ALL_DUPS  # don't record duplicates in history
setopt HIST_REDUCE_BLANKS    # remove extra blanks
setopt HIST_IGNORE_SPACE     # don't save lines that start with a space in the history

# don't expand aliases _before_ completion has finished
#   like: git comm-[tab]
setopt complete_aliases

setopt AUTO_PUSHD            # use pushd instead of cd
setopt RM_STAR_WAIT          # confirm and wait 10 seconds if using 'rm *'
setopt EXTENDED_GLOB         # activate extended globbing patterns
