export LSCOLORS="exfxcxdxbxegedabagacad"
export CLICOLOR=true

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
#setopt HIST_VERIFY
setopt SHARE_HISTORY         # share history between sessions ???
setopt EXTENDED_HISTORY      # add timestamps to history
setopt PROMPT_SUBST          # parameter expansion, command substitution, arithmetic expansion
setopt CORRECT               # spell correction
setopt COMPLETE_IN_WORD      # autocomplete from cursor even if cursor is in middle of word
setopt IGNORE_EOF            # don't exit on EOF (use exit or logout commands to exit)

setopt APPEND_HISTORY        # adds history
setopt INC_APPEND_HISTORY    # adds history incrementally
setopt SHARE_HISTORY         # share history across sessions
setopt HIST_IGNORE_ALL_DUPS  # don't record duplicates in history
setopt HIST_REDUCE_BLANKS    # remove extra blanks

# don't expand aliases _before_ completion has finished
#   like: git comm-[tab]
setopt complete_aliases

setopt AUTO_PUSHD            # use pushd instead of cd
setopt RM_STAR_WAIT          # confirm and wait 10 seconds if using 'rm *'
setopt EXTENDED_GLOB         # activate extended globbing patterns
